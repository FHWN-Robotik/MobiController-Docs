---
layout: default
title: uROS Template
parent: Setup
has_children: false
---
# Aufgabenstellung: Status-LED mit ROS 2 steuern

Ziel ist es, mit Hilfe von ROS 2 und dem µROS Agent einen einfachen Kommunikationsfluss zwischen einem Publisher und einem Subscriber aufzubauen:

- Die **blaue Taste B1** auf dem **Nucleo-L452RE-P Board** dient als **Publisher**.
- Die **grüne LED LD4** fungiert als **Subscriber** und reagiert auf das empfangene Signal.
- Kommuniziert wird über das Topic: `/status`

Der **µROS Agent** auf dem **Raspberry Pi** stellt die Verbindung zwischen dem STM32 und dem ROS 2 Netzwerk her.  
Beobachte sowohl den Publisher (Taster) als auch den Subscriber (LED) im ROS 2 System – zum Beispiel mit:

```bash
ros2 topic echo /status
```

## 1. Requirements

### 1.1 Windows 11
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html)
- [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html#get-software)
- [usbipd](https://github.com/dorssel/usbipd-win)
- [WSL 2](https://learn.microsoft.com/de-de/windows/wsl/install)

### 1.2 Linux
- [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html)

## 2. Installation der Software (Windows)

### 2.1 WSL 2

Zum Installieren vom WSL 2 die Windows PowerShell im Administratormodus öffnen, und den Befehl
`wsl --install`
ausführen. Dadurch wird WSL 2 mit Ubuntu installiert. Nach der Installation lässt sich Ubuntu einfach durch das Suchen von ***Ubuntu*** öffnen. Ein beliebiger Benutzer kann erstellt werden.


### 2.2 STM32CubeIDE & STM32CubeMX
Auf der Website die neueste Version der STM32CubeIDE herunterladen. ZIP-Datei entpacken und den Installer ausführen. Bei der Installation kann ein Verzeichnis angegeben werden, ist jedoch nicht notwendig. Beim Schritt ***Choose Components*** sicherstellen, dass die ST-LINK Treiber angehakt sind. Danach auf ***Install*** klicken und den Prozess fertig rennen lassen. Nach der Installation sind keine weiteren Schritte notwendig.

Das selbe Verfahren gilt auch für STM32CubeMX

### 2.3 usbipd
usbipd wird benötigt, um das angeschlossene STM32 Board, an den Docker Container weiterzugeben. Zum installieren am Besten ***winget*** verwenden oder alternativ den [.msi-installer](https://github.com/dorssel/usbipd-win/releases/tag/v4.3.0) von GitHub.

### 2.4 Docker Desktop
Installer herunterladen und ausführen. Sicherstellen dass ***Use WSL 2 instead of Hyper-V*** angehakt ist.
Auf ***Ok*** klicken und den Installationsprozess fertig rennen lassen. Anschließend mit ***Close and log out*** den Prozess beenden. ACHTUNG! Damit fährt der PC runter. Nach einem Neustart kann nun Docker Desktop ausgeführt werden. Beim ersten Öffnen des Programms muss ein Service Agreement akzeptiert werden(Dieses natürlich gründlich durchlesen). Es gibt die Wahl sich einzuloggen, ist aber nicht Notwendig.

Ein wichtiger Schritt ist das Aktivieren vom ***host networking***. Dazu die Einstellungen öffnen und unter ***Resources -> Network -> Enable host networking*** das Häkchen setzen. Optional kann man das interne Docker Terminal aktivieren. Dazu bei ***General -> Enable Docker terminal*** das Häckhen setzen. Nach den Einstellungen ***Apply & restart*** klicken. Damit ist die Docker-Einrichtung erledigt.

## 3. uROS Projekt

### 3.1 STM32 Projekt erstellen (CubeMX)

CubeMX starten und ein neues Projekt unter ***File -> New Project*** anlegen. Den obigen Tab ***Board Selector*** auswählen und nach dem gewünschten Board suchen, in dem Fall wird das ***NUCLEO-L452RE-P*** Board verwendet. Danach in der Liste auswählen und auf ***Start Project*** klicken. Einen beliebigen Projektnamen eingeben und die restlichen Einstellungen einfach übernehmen. Bei der Frage ***Initialize all peripherals with their default Mode?*** auf ***Yes*** klicken. 

### 3.2 FREERTOS Konfiguration des Nucleo Boards (CubeMX)

Nach dem Erstellen des Projektes, wird ***Projektname.ioc*** geöffnet. Hier finden sämtliche Hardwareeinstellungen statt. Die Pin Konfiguration ist je nach Projekt selber zu definieren. Hier werden ausschließlich folgende Konfigurationen für uROS definiert.

1. Gehe zu ***System Core -> RCC -> High Speed Clock(HSE)*** und wähle ***Crystal/Ceramic Resonator*** aus
1. Gehe zu ***System Core -> SYS -> Timebase Source*** und wähle einen gewünschten Timer aus z.B. TIM16 
1. Gehe zu ***Middleware -> FREERTOS -> Interface*** und wähle CMSIS_V2 aus
1. Ebenfalls in ***FREERTOS -> Configuration -> Task and Queues*** mache einen Doppelklick auf ***defaultTask*** und stelle die ***Allocation*** auf ***Static*** und danach die ***Stack Size(Words)*** auf ***3000***.
1. Danach noch in ***Advanced Settings -> USE_NEWLIB_REENTRANT*** auf ***Enabled*** setzen.
1. Bei ***Connectivity*** wähle das gewünschte Interface. Beim ***NUCLEO-L452RE-P*** nehmen wir das USART2 Interface.
1. Bei ***USART2 -> Configuration -> DMA Settings*** füge beide ***DMA Requests*** hinzu. Stelle bei beiden die ***Priority*** auf ***Very High***, und nur bei ***USART2_RX*** den Mode auf ***Circular***.
1. Danach gehe zu ***NVIC Settings*** und setze ein Häkchen bei ***USART2 global interrupt***.
1. Im ***Project Manager*** unter dem Punkt ***Toolchain/IDE*** im Dropdown Menu ***Makefile*** auswählen.
1. Ebenfalls im ***Project Manager*** im Tab ***Code Generator*** den Punkt ***Generate peripheral initialization as a pair of '.c/.h' files per peripheral*** anhaken.
1. Danach einfach auf ***Generate Code*** klicken.
1. Mittels ***Strg+S*** das Projekt abspeichern. Dazu am Besten einen Projektordner erstellen.

Damit ist die Hardwarekonfiguration abgeschlossen. Als nächstes müssen wir µROS für den STM32 builden und im Projekt einbinden.

### 3.3 µROS Implementierung ins Projekt (CubeIDE)

{: .note}
Man kann das Projekt auch in VSCode mit der Extension ***stm32-for-vscode*** öffnen.

Ich dem Projektordner wird das uROS Ordner benötigt, dazu den Ordner aus der GitHub Repository klonen.

- Über ein Terminal den ***git clone*** Befehl ausführen, sollte der Befehl ein Problem machen, kann das Repository auch einfach als .zip heruntergeladen, und in den Projektordner entpackt werden. [Link](https://github.com/micro-ROS/micro_ros_stm32cubemx_utils)

````bash
git clone https://github.com/micro-ROS/micro_ros_stm32cubemx_utils.git
````

{: .note}
Den uROS Ordnernamen ändern auf ***micro_ros_stm32cubemx_utils***, denn je nach ROS Version kommt die Endung dazu.

2. Die CubeIDE starten oben auf ***File ->  Makefile Project with existing Code***
2. Verzeichnis vom Projektordner suchen über ***Browse...***
2. Toolchain for Indexer Settings -> ***MCU ARM GCC***
2. Wenn man jetzt das leere Projekt kompiliert über den Hammer, kommen ein paar Fehler.
***_close_r ; _lseek_r ; _read_r ; _write_r***
das kommt davon, weil die zwei Dateien syscalls.c und sysmem.c im ***Core -> Src*** nicht automatisch im Makefile ergänzt werden.
Deshalb im Makefile folgende Zeilen ergänzen.

```diff
...
######################################
# source
######################################
# C sources
C_SOURCES =  \
Core/Src/main.c \
Core/Src/gpio.c \
...
- (beim Vorletzten \ nicht vergessen :)) 
+ Core/Src/sysmem.c \
+ Core/Src/syscalls.c
```

Durch Build kann man jetzt kontrollieren, ob soweit alles passt.

Damit der uROS Ordner beim Build Vorgang auch vom Kompiler gefunden wird, wird im Makefile vor dem ***build the application*** folgendes erweitert.

```diff
...
+ #######################################
+ # micro-ROS addons
+ #######################################
+ LDFLAGS += micro_ros_stm32cubemx_utils/microros_static_library/libmicroros/libmicroros.a
+ C_INCLUDES += -Imicro_ros_stm32cubemx_utils/microros_static_library/libmicroros/microros_include
+ # Add micro-ROS utils
+ C_SOURCES += micro_ros_stm32cubemx_utils/extra_sources/custom_memory_manager.c
+ C_SOURCES += micro_ros_stm32cubemx_utils/extra_sources/microros_allocators.c
+ C_SOURCES += micro_ros_stm32cubemx_utils/extra_sources/microros_time.c
+ # Set here the custom transport implementation
+ C_SOURCES += micro_ros_stm32cubemx_utils/extra_sources/microros_transports/dma_transport.c
+ print_cflags:
+ 	@echo $(CFLAGS)

#######################################
# build the application
#######################################
# list of objects
...
```

- Nach dem das Makefile bereit ist. Navigiere über den Terminal in das Projektverzeichnis.
- Oder öffne den Projektordner über den Explorer und mit rechtsklick ***in Terminal öffnen***
Damit die uROS Bibliothek kompiliert wird, führe folgende Docker Befehle aus.
Es werden Warnings erscheinen, diese beeinträchtigen die Funktion nicht.

````shell
docker pull microros/micro_ros_static_library_builder:humble
docker run -it --rm -v $(pwd):/project --env MICROROS_LIBRARY_FOLDER=micro_ros_stm32cubemx_utils/microros_static_library microros/micro_ros_static_library_builder:humble
````

{: .note}
***$(pwd)*** funktioniert nur in Linux, stattdessen absoluten Pfad kopieren und einfügen.

Zum Testen kann über Build erneut kompiliert werden.

### 3.4 Code anpassen

***main.c*** wird grundsätzlich nicht verwendet. Alle uROS funktionalitäten werden in ***freertos.c*** eingesetzt.

Unter ***Core -> Src*** die Dateien ***freertos.c*** öffnen. Folgende Änderungen müssen vorgenommen werden:

- Unter ***Private includes***:

```c
/* Private includes ------------*/
/* USER CODE BEGIN Includes */
#include <rcl/rcl.h>
#include <rcl/error_handling.h>
#include <rclc/rclc.h>
#include <rclc/executor.h>
#include <uxr/client/transport.h>
#include <rmw_microxrcedds_c/config.h>
#include <rmw_microros/rmw_microros.h>

#include <std_msgs/msg/int32.h>
#include "usart.h"
/* USER CODE END Includes */
```

- Über  ***Private function prototypes*** sollte dieser Absatz vorhanden sein.

```c
/* Definitions for defaultTask */
osThreadId_t defaultTaskHandle;
uint32_t defaultTaskBuffer[ 3000 ];
osStaticThreadDef_t defaultTaskControlBlock;
const osThreadAttr_t defaultTask_attributes = {
    .name = "defaultTask",
    .cb_mem = &defaultTaskControlBlock,
    .cb_size = sizeof(defaultTaskControlBlock),
    .stack_mem = &defaultTaskBuffer[0],
    .stack_size = sizeof(defaultTaskBuffer),
    .priority = (osPriority_t) osPriorityNormal,
};
```

- Unter ***Private function prototypes***:

```c
/* Private function prototypes ------------*/
/* USER CODE BEGIN FunctionPrototypes */
bool cubemx_transport_open(struct uxrCustomTransport * transport);
bool cubemx_transport_close(struct uxrCustomTransport * transport);
size_t cubemx_transport_write(struct uxrCustomTransport* transport, const uint8_t * buf, size_t len, uint8_t * err);
size_t cubemx_transport_read(struct uxrCustomTransport* transport, uint8_t* buf, size_t len, int timeout, uint8_t* err);

void * microros_allocate(size_t size, void * state);
void microros_deallocate(void * pointer, void * state);
void * microros_reallocate(void * pointer, size_t size, void * state);
void * microros_zero_allocate(size_t number_of_elements, size_t size_of_element, void * state);

/* USER CODE END FunctionPrototypes */
```

Zusätzlich dieses Prototyp für die Aufgabenstellung einfügen.
Dieser wird erst ganz unten definiert.

```c
void status_callback(const void *msgin); 
```

- Jetzt wird der DefaultTast, der als "main" dient ergänzt.

```c
/* USER CODE BEGIN Header_StartDefaultTask */
/**
 * @brief  Function implementing the defaultTask thread.
 * @param  argument: Not used
 * @retval None
 */
/* USER CODE END Header_StartDefaultTask */
void StartDefaultTask(void *argument) {
	/* USER CODE BEGIN StartDefaultTask */

	// 1. Setze benutzerdefinierten Transport über UART (z. B. UART2)
	    //    Der µROS Agent am Raspberry Pi kommuniziert über Serial (USB→UART).
	rmw_uros_set_custom_transport(
	true, (void*) &huart2, cubemx_transport_open, cubemx_transport_close,
			cubemx_transport_write, cubemx_transport_read);

	// 2. Definiere und konfiguriere benutzerdefinierten Speicher-Allocator
	    //    µROS verwendet diesen Allocator für alle dynamischen Speicheroperationen.
	rcl_allocator_t freeRTOS_allocator = rcutils_get_zero_initialized_allocator();
	freeRTOS_allocator.allocate = microros_allocate;
	freeRTOS_allocator.deallocate = microros_deallocate;
	freeRTOS_allocator.reallocate = microros_reallocate;
	freeRTOS_allocator.zero_allocate = microros_zero_allocate;

	// 3. Setze diesen Allocator als globalen Default für rcl/rmw
	if (!rcutils_set_default_allocator(&freeRTOS_allocator)) {
		printf("Error on default allocators (line %d)\n", __LINE__);
	}

	// 4. Initialisiere micro-ROS Unterstützung (rclc-support)
	    //    support beinhaltet Kontext, Allocator, Init-Optionen
	rclc_support_t support;
	rclc_support_init(
			&support,
			0,
			NULL,
			&freeRTOS_allocator);

	// 5. Erzeuge Node „status_node“
	rcl_node_t node;
	rclc_node_init_default(
			&node,
			"status_node",
			"",
			&support);

	// 6. Erzeuge Publisher für Topic /Status (Integer-Nachricht)
	rcl_publisher_t publisher;
	std_msgs__msg__Int32 pub_msg;
	rclc_publisher_init_default(
			&publisher,
			&node,
			ROSIDL_GET_MSG_TYPE_SUPPORT(std_msgs, msg, Int32),
			"Status");

	// 7. Erzeuge Subscriber für Topic /Status (gleicher Typ)
	rcl_subscription_t subscriber;
	std_msgs__msg__Int32 sub_msg;
	rclc_subscription_init_default(
			&subscriber,
			&node,
			ROSIDL_GET_MSG_TYPE_SUPPORT(std_msgs, msg, Int32),
			"Status");

	// 8. Erzeuge rclc-Executor zum Verwalten von Subscriptions (und ggf. Timern)
	rclc_executor_t executor;
	rclc_executor_init(
			&executor,
			&support.context,
			1,
			&freeRTOS_allocator);

	 // 9. Füge die Subscription zum Executor hinzu
	rclc_executor_add_subscription(
			&executor,
			&subscriber,
			&sub_msg,
			&status_callback,
			ON_NEW_DATA);

	 // 10. Startwert des Publishers setzen
	pub_msg.data = 0;

	// 11. Endlosschleife (FreeRTOS-Task)
	for (;;) {

		// 11.1 Taste B1 (PC13) prüfen – gedrückt = Low → 1 senden
		if (HAL_GPIO_ReadPin(B1_GPIO_Port, B1_Pin) == GPIO_PIN_RESET) {
			pub_msg.data = 1;
		} else {
			pub_msg.data = 0;
		}

		// 11.2 Nachricht publizieren
		rcl_publish(&publisher, &pub_msg, NULL);

		// 11.3 Eingehende Nachrichten verarbeiten (Subscriber)
		rclc_executor_spin_some(&executor, RCL_MS_TO_NS(10));

		// 11.4 Delay von 100 ms → 10 Hz Loop
		osDelay(100);  // 10 Hz
	}
	/* USER CODE END StartDefaultTask */
}
```

- Jetzt wird noch der Callback für den Sub definiert.

```c
/* USER CODE BEGIN Application */

void status_callback(const void *msgin) {

	// 1. Nachricht umcasten von void-Pointer auf konkreten Typ
	const std_msgs__msg__Int32 *msg = (const std_msgs__msg__Int32*) msgin;

	// 2. Daten auswerten und LED entsprechend schalten
	if (msg->data)
		HAL_GPIO_WritePin(LD4_GPIO_Port, LD4_Pin, GPIO_PIN_SET);   // LD4 an
	else
		HAL_GPIO_WritePin(LD4_GPIO_Port, LD4_Pin, GPIO_PIN_RESET); // LD4 aus
}

/* USER CODE END Application */ 
```

Mit dem ***Run*** Button oben, kann der Code auf den Nucleo Board gespielt werden. 

### 3.5 Testen mit WSL2

Wenn ROS2 auf dem WSL2 mit einem Workspace eingerichtet ist, wird der uROS Agent benötigt, siehe [uROS Agent Dokumentation]({{ site.baseurl }}/ros2/micro_ros_agent.html).

Auf Windows muss noch die USB Schnittstelle zu WSL2 verbunden werden, siehe [Verbinden von USB-Geräten](https://learn.microsoft.com/de-de/windows/wsl/connect-usb#attach-a-usb-device).
Das erste Befehl muss als Admin ausgeführt werden, deshalb ***PowerShell*** als Admin starten.

Die vorhandenen USB Geräte anzeigen und die BUSID von ST-Link finden. 

```bash
usbipd list
```

Jetzt die ST-Link Schnittstelle freigeben mit der BUSID.

```bash
usbipd bind --busid <busid>
```

Diese zwei Befehle müssen nicht mehr ausgeführt werden und die weiteren Befehle benötigen keine Adminrechte mehr.

Den ST-Link kann man nun jedes mal mit dem folgenden Befehl an WSL2 verbinden.

```bash
usbipd attach --wsl --busid <busid>
```

Jetzt kann ST-Link nicht mehr über Windows benutzt werden. Damit sie wieder freigegeben wird, muss dieser Befehl benutzt werden.

```bash
usbipd detach --busid <busid>
```

Mit diesem Befehl kann man in ***WSL2 im Terminal*** sehen, ob das attach funktioniert hat.

```bash
lsusb
```

{: .note}
Also wenn man den Nucleo programmieren möchte muss davor das Befehl deattach ausgeführt werden.

Da die USB Schnittstelle in WSL2 für stm32 nicht mit dem Namen eingerichtet ist, wird dieser Befehl zum Ausführen vom Agenten benutzt.

```bash
ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyACM0
```

Jetzt auf dem Nucleo Board die schwarte Taste (Reset) drücken und im Terminal sollten die Pub und Sub erstellt werden.

In einem neuen Terminal können die Topics gesucht werden. 

```bash
ros2 topic list
```

Zusätzlich nach dem der Agent rennt, kann man die blaue Taste auf dem Nucleo drücken und die LD4 ausschalten.

## 4. TEST mit Docker ROS (Windows) 

### 4.1 ROS Container laden und aufsetzen

1. Docker Desktop starten
2. In der Suchleiste nach ROS suchen -> Im Dropdownmenu ***humble*** auswählen -> ***Run*** klicken
3. Der Container sollte kurz starten und dann sofort wieder stoppen. Dieses Verhalten ist gewünscht.
4. Danach entweder in einer Powershell oder in der Command Line von Docker Desktop folgende Befehle eingeben

```shell
# Mittels usbipd list lassen sich alle verbundenen USB Geräte auflisten
# In der Auflistung sind die Bus IDs angeführt
usbipd list
# Danach führt man diesen Befehl mit der Bus ID vom STM32 aus
usbipd attach --wsl --busid X-Y
```

5. Nachdem der STM32 im WSL eingebunden wurde, kopiert man den Run Befehl des vorher gestarteten Containers. Dazu in Docker Desktop im Tab ***Containers*** im Menu ***Actions*** die drei Punkte anklicken und dann ***Copy docker run*** auswählen.

6. Des kopierten Run Befehl in der Command Line einfügen und den Anfang auf folgendes Muster anpassen

```shell
docker run -it --device /dev/ttyACM0 ...
```

7. Dadurch wird beim Starten des Containers der STM32 zugreifbar gemacht
8. Ab diesem Punkt folgt man der Anleitung der FHWN MobiController Docs unter folgendem Link: https://fhwn-robotik.github.io/MobiController-Docs/ros2/micro_ros_agent.html
