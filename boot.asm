boot.asm
kernel.c
linker.ld
ENTRY(_start)

SECTIONS
{
    . = 1M;

    .text :
    {
        *(.text)
    }

    .rodata :
    {
        *(.rodata)
    }

    .data :
    {
        *(.data)
    }

    .bss :
    {
        *(.bss)
    }
}
grub.cfg
Makefile
README.md
LICENSE
AXOS/
│
├── kernel/
│   ├── screen.h
│   ├── screen.c
│   │
│   ├── keyboard.h
│   ├── keyboard.c
│   │
│   ├── memory.h
│   ├── memory.c
│   │
│   ├── interrupts.h
│   ├── interrupts.c
│   │
│   ├── filesystem.h
│   ├── filesystem.c
│   │
│   ├── loader.h
│   └── loader.c
│
├── drivers/
│   ├── mouse.h
│   ├── mouse.c
│   ├── disk.h
│   └── disk.c
│
├── apps/
│   └── hello.axa
│
├── tools/
│   └── axac.c
│
└── include/
    └── types.h
    #ifndef TYPES_H
kernel/
├── syscall.h
└── syscall.c
#ifndef SYSCALL_H
#define SYSCALL_H


void syscall_print(char* text);

void syscall_exit();


#endif
#include "syscall.h"
#include "screen.h"


void syscall_print(char* text)
{

    print(text);

}



void syscall_exit()
{

    while(1)
    {

    }

}
kernel/
├── task.h
└── task.c
#ifndef TASK_H
#define TASK_H

#include "../include/types.h"


#define MAX_TASKS 32


typedef struct
{
    uint32_t id;

    uint32_t active;

    void (*function)();


} Task;



void task_init();

int task_create(void (*function)());

void task_run();


#endif
#include "task.h"


Task tasks[MAX_TASKS];

int task_count = 0;



void task_init()
{

    task_count = 0;

}



int task_create(void (*function)())
{

    if(task_count >= MAX_TASKS)
    {
        return -1;
    }


    tasks[task_count].id = task_count;

    tasks[task_count].active = 1;

    tasks[task_count].function = function;


    task_count++;


    return task_count - 1;

}



void task_run()
{

    for(int i = 0; i < task_count; i++)
    {

        if(tasks[i].active)
        {

            tasks[i].function();

        }

    }

}
kernel/
├── user.h
└── user.c
#ifndef USER_H
#define USER_H


void user_init();


int user_run(void (*program)());


#endif
#include "user.h"


void user_init()
{

}



int user_run(void (*program)())
{

    if(program == 0)
    {
        return -1;
    }


    program();


    return 0;

}
kernel/
├── timer.h
└── timer.c
#ifndef TIMER_H
#define TIMER_H


void timer_init();


unsigned int timer_get();


#endif
#include "timer.h"


unsigned int ticks = 0;



void timer_init()
{

    ticks = 0;

}



unsigned int timer_get()
{

    return ticks;

}
kernel/
├── panic.h
└── panic.c
#ifndef PANIC_H
#define PANIC_H


void kernel_panic(char* message);


#endif
#include "panic.h"
#include "screen.h"



void kernel_panic(char* message)
{

    clear_screen();


    print("AXOS KERNEL PANIC");


    print("\n");


    print(message);



    while(1)
    {

    }

}
kernel/
├── random.h
└── random.c
#ifndef RANDOM_H
#define RANDOM_H


void random_init(unsigned int seed);


unsigned int random_get();


#endif
#include "random.h"


unsigned int random_value = 1;



void random_init(unsigned int seed)
{

    random_value = seed;

}



unsigned int random_get()
{

    random_value = random_value * 1103515245 + 12345;


    return (random_value >> 16) & 0x7FFF;

}
kernel/
├── string.h
└── string.c
#ifndef STRING_H
#define STRING_H


int strlen(char* text);

void strcpy(char* destination, char* source);

int strcmp(char* a, char* b);


#endif
#include "string.h"



int strlen(char* text)
{

    int length = 0;


    while(text[length] != 0)
    {

        length++;

    }


    return length;

}





void strcpy(char* destination, char* source)
{

    int i = 0;


    while(source[i] != 0)
    {

        destination[i] = source[i];

        i++;

    }


    destination[i] = 0;

}





int strcmp(char* a, char* b)
{

    int i = 0;


    while(a[i] && b[i])
    {

        if(a[i] != b[i])
        {

            return 1;

        }


        i++;

    }


    if(a[i] == b[i])
    {

        return 0;

    }


    return 1;

}
kernel/
├── terminal.h
└── terminal.c
#ifndef TERMINAL_H
#define TERMINAL_H


void terminal_init();

void terminal_write(char* text);

void terminal_prompt();


#endif
#include "terminal.h"
#include "screen.h"



void terminal_init()
{

    clear_screen();

    terminal_write("AXOS Terminal\n");

    terminal_prompt();

}



void terminal_write(char* text)
{

    print(text);

}



void terminal_prompt()
{

    print("> ");

}
kernel/
├── app_manager.h
└── app_manager.c
run hello.axa
kernel/
├── desktop.h
└── desktop.c
kernel/
└── init.h
└── init.c
#ifndef INIT_H
#define INIT_H

void kernel_init();

#endif
#include "init.h"

#include "screen.h"
#include "keyboard.h"
#include "memory.h"
#include "interrupts.h"
#include "filesystem.h"
#include "process.h"
#include "task.h"
#include "timer.h"
#include "terminal.h"


void kernel_init()
{

    clear_screen();


    memory_init();

    interrupts_init();

    filesystem_init();

    process_init();

    task_init();

    timer_init();


    terminal_init();


}
#include "init.h"


void kernel_main()
{

    kernel_init();


    while(1)
    {

    }

}
kernel/
├── desktop.h
└── desktop.c
kernel/
├── gui.h
└── gui.c
#ifndef GUI_H
#define GUI_H


void gui_init();

void gui_draw();


#endif
#include "gui.h"

#include "screen.h"



void gui_init()
{

    // Initialisation de l'interface graphique AXOS

}



void gui_draw()
{

    clear_screen();


    print("AXOS GUI");


}
kernel/
├── window.h
└── window.c
#ifndef WINDOW_H
#define WINDOW_H


typedef struct
{

    int x;

    int y;

    int width;

    int height;

    char* title;


} Window;



void window_create(
    Window* window,
    int x,
    int y,
    int width,
    int height,
    char* title
);


void window_draw(Window* window);


#endif
#include "window.h"

#include "screen.h"



void window_create(
    Window* window,
    int x,
    int y,
    int width,
    int height,
    char* title
)
{

    window->x = x;

    window->y = y;

    window->width = width;

    window->height = height;

    window->title = title;

}



void window_draw(Window* window)
{

    print(window->title);

}
kernel/
├── button.h
└── button.c
#ifndef BUTTON_H
#define BUTTON_H


typedef struct
{

    int x;

    int y;

    int width;

    int height;

    char* text;


} Button;



void button_create(
    Button* button,
    int x,
    int y,
    int width,
    int height,
    char* text
);



void button_draw(Button* button);



#endif
#include "button.h"

#include "screen.h"



void button_create(
    Button* button,
    int x,
    int y,
    int width,
    int height,
    char* text
)
{

    button->x = x;

    button->y = y;

    button->width = width;

    button->height = height;

    button->text = text;

}



void button_draw(Button* button)
{

    print("[ ");

    print(button->text);

    print(" ]");

}
kernel/
├── cursor.h
└── cursor.c
#ifndef CURSOR_H
#define CURSOR_H


void cursor_init();


void cursor_move(
    int x,
    int y
);


void cursor_draw();


#endif
#include "cursor.h"

#include "screen.h"


int cursor_x = 0;

int cursor_y = 0;



void cursor_init()
{

    cursor_x = 0;

    cursor_y = 0;

}



void cursor_move(int x, int y)
{

    cursor_x = x;

    cursor_y = y;

}



void cursor_draw()
{

    // affichage futur du curseur graphique

    print("+" );

}
kernel/
├── userfs.h
└── userfs.c
#ifndef USERFS_H
#define USERFS_H


void userfs_init();


int userfs_create(char* name);


int userfs_delete(char* name);


char* userfs_read(char* name);



#endif
#include "userfs.h"



void userfs_init()
{

    // Initialisation du système de fichiers utilisateur AXOS

}



int userfs_create(char* name)
{

    // création future d'un fichier

    return 0;

}



int userfs_delete(char* name)
{

    // suppression future d'un fichier

    return 0;

}



char* userfs_read(char* name)
{

    // lecture future d'un fichier

    return 0;

}
kernel/
├── config.h
└── config.c
#ifndef CONFIG_H
#define CONFIG_H


void config_init();


void config_set(char* key, char* value);


char* config_get(char* key);



#endif
#include "config.h"



char username[32] = "AXOS";

char resolution[32] = "80x25";



void config_init()
{

}



void config_set(char* key, char* value)
{

    // réglages futurs

}



char* config_get(char* key)
{

    if(key[0] == 'u')
    {

        return username;

    }


    if(key[0] == 'r')
    {

        return resolution;

    }


    return 0;

}
kernel/
├── service.h
└── service.c
#ifndef SERVICE_H
#define SERVICE_H


void service_init();


int service_start(char* name);


int service_stop(char* name);



#endif
#include "service.h"



void service_init()
{

    // Initialisation des services AXOS

}



int service_start(char* name)
{

    // lancement futur d'un service

    return 0;

}



int service_stop(char* name)
{

    // arrêt futur d'un service

    return 0;

}
AXOS/
└── lib/
    ├── axa.h
    └── axa.c
    #ifndef AXA_H
#define AXA_H


void axa_print(char* text);


void axa_clear();


void axa_exit();



#endif
#include "axa.h"

#include "../kernel/syscall.h"



void axa_print(char* text)
{

    syscall_print(text);

}



void axa_clear()
{

    syscall_print("\n");

}



void axa_exit()
{

    syscall_exit();

}
apps/
└── hello.c
#include "../lib/axa.h"


void main()
{

    axa_print("Bonjour depuis AXOS");


    axa_exit();

}
kernel/
├── axa_format.h
└── axa_format.c
#ifndef AXA_FORMAT_H
#define AXA_FORMAT_H


typedef struct
{

    char magic[4];

    unsigned int size;

    unsigned int entry;


} AXAHeader;


#endif
tools/
└── axac.c
kernel/
├── syscall.h
└── syscall.c
kernel/
├── package.h
└── package.c
install app.axa
remove app.axa
kernel/
├── boot_manager.h
└── boot_manager.c
user/
├── shell.axa
├── settings.axa
└── explorer.axa
resources/
├── icons/
├── fonts/
└── themes/
release/
├── AXOS.iso
├── CHANGELOG.md
└── VERSION
kernel/main.h
kernel/main.c
#ifndef MAIN_H
#define MAIN_H


void axos_start();


#endif
#include "main.h"

#include "screen.h"
#include "memory.h"
#include "interrupts.h"
#include "filesystem.h"
#include "process.h"
#include "task.h"
#include "timer.h"
#include "config.h"
#include "service.h"
#include "desktop.h"



void axos_start()
{

    clear_screen();


    memory_init();

    interrupts_init();

    filesystem_init();

    process_init();

    task_init();

    timer_init();

    config_init();

    service_init();


    desktop_start();


}
#include "main.h"


void kernel_main()
{

    axos_start();


    while(1)
    {

    }

}
AXOS/build/
iso/boot/grub/grub.cfg
menuentry "AXOS" 
{

    multiboot /boot/axos.bin


    boot

}
CC = gcc
AS = nasm
LD = ld


CFLAGS = -m32 -ffreestanding -fno-pie -nostdlib


all: axos.bin


boot.o:
	nasm boot.asm -f elf32 -o build/boot.o


kernel.o:
	$(CC) $(CFLAGS) -c kernel.c -o build/kernel.o


kernel_main.o:
	$(CC) $(CFLAGS) -c kernel/main.c -o build/main.o


axos.bin: boot.o kernel.o kernel_main.o
	$(LD) -m elf_i386 \
	build/boot.o \
	build/kernel.o \
	build/main.o \
	-T linker.ld \
	-o build/axos.bin


iso: axos.bin
	mkdir -p iso/boot
	cp build/axos.bin iso/boot/axos.bin
	grub-mkrescue -o AXOS.iso iso


run:
	qemu-system-i386 -cdrom AXOS.iso
make
make iso
make run
kernel/
├── input.h
└── input.c
#ifndef INPUT_H
#define INPUT_H


char* input_read();


#endif
#include "input.h"
#include "keyboard.h"


char buffer[128];

int index = 0;



char* input_read()
{

    char c;


    while(1)
    {

        c = keyboard_get();


        if(c == '\n')
        {

            buffer[index] = 0;

            index = 0;


            return buffer;

        }


        if(c)
        {

            buffer[index] = c;

            index++;

        }

    }

}
#include "terminal.h"

#include "screen.h"
#include "input.h"
#include "command.h"



void terminal_init()
{

    print("AXOS Terminal\n");


    while(1)
    {

        print("> ");


        char* cmd = input_read();


        execute_command(cmd);


    }

}
kernel/
├── axa_loader.h
└── axa_loader.c
#ifndef AXA_LOADER_H
#define AXA_LOADER_H


int axa_load(char* filename);


#endif
#include "axa_loader.h"

#include "filesystem.h"
#include "screen.h"



int axa_load(char* filename)
{

    char* program;


    program = read_file(filename);



    if(program == 0)
    {

        print("AXA introuvable\n");

        return -1;

    }



    void (*entry)();



    entry = (void (*)())program;



    entry();



    return 0;

}
#include "command.h"

#include "screen.h"
#include "string.h"
#include "axa_loader.h"



void execute_command(char* command)
{

    if(strcmp(command,"help") == 0)
    {

        print("help\n");

        print("clear\n");

        print("run\n");

    }



    else if(strcmp(command,"clear") == 0)
    {

        clear_screen();

    }



    else if(strcmp(command,"run") == 0)
    {

        axa_load("hello.axa");

    }



    else
    {

        print("Commande inconnue\n");

    }

}
kernel/
├── diskfs.h
└── diskfs.c
#ifndef DISKFS_H
#define DISKFS_H


void diskfs_init();


char* diskfs_read(char* filename);



#endif
#include "diskfs.h"

#include "screen.h"



void diskfs_init()
{

    // Initialisation futur disque AXOS

}



char* diskfs_read(char* filename)
{

    print("Lecture fichier : ");

    print(filename);

    print("\n");


    return 0;

}
kernel/filesystem.c
#include "filesystem.h"

#include "diskfs.h"



void filesystem_init()
{

    diskfs_init();

}



char* read_file(char* name)
{

    return diskfs_read(name);

}
#include "diskfs.h"
diskfs_init();
filesystem/
├── axosfs.h
└── axosfs.c
#ifndef AXOSFS_H
#define AXOSFS_H


#define MAX_FILES 64


typedef struct
{

    char name[32];

    unsigned int size;

    unsigned int location;


} AXOSFile;



void axosfs_init();


int axosfs_find(char* name);


char* axosfs_load(char* name);



#endif
#include "axosfs.h"



AXOSFile files[MAX_FILES];

int file_count = 0;



void axosfs_init()
{

    file_count = 0;


}



int axosfs_find(char* name)
{

    for(int i = 0; i < file_count; i++)
    {

        if(files[i].name[0] == name[0])
        {

            return i;

        }

    }


    return -1;

}



char* axosfs_load(char* name)
{

    int id;


    id = axosfs_find(name);



    if(id < 0)
    {

        return 0;

    }



    return (char*)files[id].location;

}
#include "filesystem.h"

#include "../filesystem/axosfs.h"



void filesystem_init()
{

    axosfs_init();

}



char* read_file(char* name)
{

    return axosfs_load(name);

}
kernel/
├── installer.h
└── installer.c
#ifndef INSTALLER_H
#define INSTALLER_H


void installer_init();


int install_app(char* name);



#endif
#include "installer.h"

#include "screen.h"
#include "../filesystem/axosfs.h"



void installer_init()
{

    // Initialisation installateur AXOS

}



int install_app(char* name)
{

    print("Installation : ");

    print(name);

    print("\n");


    // Ajout futur dans AXOSFS


    return 0;

}
kernel/
├── package_manager.h
└── package_manager.c
#ifndef PACKAGE_MANAGER_H
#define PACKAGE_MANAGER_H


void package_init();


int package_install(char* name);


int package_remove(char* name);


void package_list();



#endif
#include "package_manager.h"

#include "screen.h"

#include "installer.h"



void package_init()
{

    installer_init();

}



int package_install(char* name)
{

    print("Package installation\n");


    return install_app(name);

}



int package_remove(char* name)
{

    print("Suppression package : ");

    print(name);

    print("\n");


    return 0;

}



void package_list()
{

    print("Applications AXOS\n");

}
kernel/
└── command.c
#include "command.h"

#include "screen.h"
#include "string.h"

#include "axa_loader.h"
#include "package_manager.h"



void execute_command(char* command)
{


    if(strcmp(command,"help") == 0)
    {

        print("Commandes AXOS:\n");

        print("help\n");

        print("clear\n");

        print("run\n");

        print("install\n");

        print("remove\n");

        print("list\n");

    }



    else if(strcmp(command,"clear") == 0)
    {

        clear_screen();

    }



    else if(strcmp(command,"run") == 0)
    {

        axa_load("hello.axa");

    }



    else if(strcmp(command,"install") == 0)
    {

        package_install("hello.axa");

    }



    else if(strcmp(command,"remove") == 0)
    {

        package_remove("hello.axa");

    }



    else if(strcmp(command,"list") == 0)
    {

        package_list();

    }



    else
    {

        print("Commande inconnue\n");

    }


}
filesystem/
├── app_db.h
└── app_db.c
#ifndef APP_DB_H
#define APP_DB_H


#define MAX_APPS 64


void appdb_init();


int appdb_add(char* name);


int appdb_remove(char* name);


void appdb_list();



#endif
#include "app_db.h"

#include "../kernel/screen.h"



char apps[MAX_APPS][32];

int app_count = 0;



void appdb_init()
{

    app_count = 0;

}



int appdb_add(char* name)
{

    if(app_count >= MAX_APPS)
    {

        return -1;

    }


    int i = 0;


    while(name[i])
    {

        apps[app_count][i] = name[i];

        i++;

    }


    apps[app_count][i] = 0;


    app_count++;


    return 0;

}



int appdb_remove(char* name)
{

    return 0;

}



void appdb_list()
{

    print("Apps installees:\n");


    for(int i = 0; i < app_count; i++)
    {

        print(apps[i]);

        print("\n");

    }

}
#include "../filesystem/app_db.h"
void package_init()
{

    installer_init();

    appdb_init();

}
int package_install(char* name)
{

    install_app(name);

    appdb_add(name);


    return 0;

}
filesystem/
├── save.h
└── save.c
#ifndef SAVE_H
#define SAVE_H


void save_init();


void save_apps();


void load_apps();



#endif
#include "save.h"

#include "app_db.h"

#include "../kernel/screen.h"



void save_init()
{

    load_apps();

}



void save_apps()
{

    print("Sauvegarde AXOS\n");


}



void load_apps()
{

    print("Chargement AXOS\n");


}
#include "../filesystem/save.h"
save_init();
filesystem_init();
kernel/
├── security.h
└── security.c
#ifndef SECURITY_H
#define SECURITY_H


void security_init();


int check_permission(char* user, char* action);



#endif
#include "security.h"

#include "screen.h"



char current_user[32] = "root";



void security_init()
{

    print("Security AXOS active\n");


}



int check_permission(char* user, char* action)
{

    if(user[0] == 'r')
    {

        return 1;

    }


    return 0;

}
#include "security.h"
security_init();
config_init();
kernel/
├── log.h
└── log.c
#ifndef LOG_H
#define LOG_H


void log_init();


void log_write(char* message);



#endif
#include "log.h"

#include "screen.h"



void log_init()
{

    print("AXOS Log system active\n");

}



void log_write(char* message)
{

    print("[LOG] ");

    print(message);

    print("\n");

}
#include "log.h"
log_init();
security_init();
kernel/
├── network.h
└── network.c
#ifndef NETWORK_H
#define NETWORK_H


void network_init();


int network_send(char* data);


int network_receive(char* buffer);



#endif
#include "network.h"

#include "screen.h"



void network_init()
{

    print("AXOS Network active\n");

}



int network_send(char* data)
{

    return 0;

}



int network_receive(char* buffer)
{

    return 0;

}
kernel/
├── usb.h
└── usb.c
#ifndef USB_H
#define USB_H


void usb_init();


#endif
#include "usb.h"

#include "screen.h"



void usb_init()
{

    print("AXOS USB active\n");

}
kernel/
├── audio.h
└── audio.c
#ifndef AUDIO_H
#define AUDIO_H


void audio_init();


#endif
#include "audio.h"

#include "screen.h"



void audio_init()
{

    print("AXOS Audio active\n");

}
kernel/
├── device.h
└── device.c
#ifndef DEVICE_H
#define DEVICE_H


void device_init();


#endif
#include "device.h"

#include "screen.h"



void device_init()
{

    print("Devices AXOS loaded\n");

}
#include "network.h"
#include "usb.h"
#include "audio.h"
#include "device.h"
network_init();

usb_init();

audio_init();

device_init();
kernel/
├── gui_manager.h
└── gui_manager.c
#ifndef GUI_MANAGER_H
#define GUI_MANAGER_H


void gui_manager_init();


void gui_manager_update();



#endif
#include "gui_manager.h"

#include "screen.h"



void gui_manager_init()
{

    print("AXOS GUI Manager loaded\n");

}



void gui_manager_update()
{

}
kernel/
├── window_manager.h
└── window_manager.c
#ifndef WINDOW_MANAGER_H
#define WINDOW_MANAGER_H


void window_manager_init();


void window_manager_update();


#endif
#include "window_manager.h"

#include "screen.h"



void window_manager_init()
{

    print("Window Manager loaded\n");

}



void window_manager_update()
{

}
#include "gui_manager.h"
#include "window_manager.h"
gui_manager_init();

window_manager_init();
kernel/
├── vmemory.h
└── vmemory.c
#ifndef VMEMORY_H
#define VMEMORY_H


void vmemory_init();


void map_memory(
    unsigned int virtual_addr,
    unsigned int physical_addr
);



#endif
#include "vmemory.h"

#include "screen.h"



void vmemory_init()
{

    print("Virtual memory active\n");


}



void map_memory(
    unsigned int virtual_addr,
    unsigned int physical_addr
)
{

}
#include "vmemory.h"
vmemory_init();
memory_init();
kernel/
├── scheduler.h
└── scheduler.c
#ifndef SCHEDULER_H
#define SCHEDULER_H


void scheduler_init();


void scheduler_run();


void scheduler_add(void (*task)());



#endif
#include "scheduler.h"

#include "screen.h"



#define MAX_TASKS 32



void (*tasks[MAX_TASKS])();

int task_count = 0;

int current_task = 0;



void scheduler_init()
{

    task_count = 0;

    current_task = 0;


    print("Scheduler active\n");

}



void scheduler_add(void (*task)())
{

    if(task_count < MAX_TASKS)
    {

        tasks[task_count] = task;

        task_count++;

    }

}



void scheduler_run()
{

    while(1)
    {

        if(task_count > 0)
        {

            tasks[current_task]();


            current_task++;


            if(current_task >= task_count)
            {

                current_task = 0;

            }

        }

    }

}
#include "scheduler.h"
scheduler_init();
task_init();
filesystem/
├── file.h
└── file.c
#ifndef FILE_H
#define FILE_H


#define MAX_FILES 128


typedef struct
{

    char name[32];

    unsigned int size;

    char* data;


} File;



void file_init();


int file_create(char* name);


char* file_read(char* name);


int file_write(char* name, char* data);



#endif
#include "file.h"



File files[MAX_FILES];

int file_count = 0;



void file_init()
{

    file_count = 0;

}



int file_create(char* name)
{

    if(file_count >= MAX_FILES)
    {

        return -1;

    }


    files[file_count].name[0] = name[0];


    file_count++;


    return 0;

}



char* file_read(char* name)
{

    for(int i = 0; i < file_count; i++)
    {

        if(files[i].name[0] == name[0])
        {

            return files[i].data;

        }

    }


    return 0;

}



int file_write(char* name, char* data)
{

    return 0;

}
#include "../filesystem/file.h"
file_init();
filesystem_init();
filesystem/
├── directory.h
└── directory.c
#ifndef DIRECTORY_H
#define DIRECTORY_H


#define MAX_DIRS 64


typedef struct
{

    char name[32];


} Directory;



void directory_init();


int directory_create(char* name);


int directory_exists(char* name);



#endif
#include "directory.h"



Directory directories[MAX_DIRS];

int directory_count = 0;



void directory_init()
{

    directory_count = 0;


}



int directory_create(char* name)
{

    if(directory_count >= MAX_DIRS)
    {

        return -1;

    }



    directories[directory_count].name[0] = name[0];


    directory_count++;


    return 0;

}



int directory_exists(char* name)
{

    for(int i = 0; i < directory_count; i++)
    {

        if(directories[i].name[0] == name[0])
        {

            return 1;

        }

    }


    return 0;

}
#include "../filesystem/directory.h"
file_init();
directory_init();
filesystem/
├── path.h
└── path.c
#ifndef PATH_H
#define PATH_H


int path_check(char* path);


char* path_filename(char* path);



#endif
#include "path.h"



int path_check(char* path)
{

    if(path[0] == '/')
    {

        return 1;

    }


    return 0;

}



char* path_filename(char* path)
{

    int i = 0;


    while(path[i])
    {

        i++;

    }


    return &path[i];

}
#include "../filesystem/path.h"
directory_init();
kernel/
├── user_process.h
└── user_process.c
#ifndef USER_PROCESS_H
#define USER_PROCESS_H


#define MAX_USER_PROCESS 32


typedef struct
{

    int id;

    char name[32];

    int active;


} UserProcess;



void user_process_init();


int user_process_create(char* name);


void user_process_kill(int id);



#endif
#include "user_process.h"

#include "screen.h"



UserProcess processes[MAX_USER_PROCESS];

int process_count = 0;



void user_process_init()
{

    process_count = 0;


    print("User processes active\n");

}



int user_process_create(char* name)
{

    if(process_count >= MAX_USER_PROCESS)
    {

        return -1;

    }



    processes[process_count].id = process_count;


    processes[process_count].name[0] = name[0];


    processes[process_count].active = 1;



    process_count++;


    return process_count - 1;

}



void user_process_kill(int id)
{

    if(id < process_count)
    {

        processes[id].active = 0;

    }

}
#include "user_process.h"
process_init();
user_process_init();
kernel/
├── ipc.h
└── ipc.c
#ifndef IPC_H
#define IPC_H


void ipc_init();


int ipc_send(
    int process_id,
    char* message
);



int ipc_receive(
    int process_id,
    char* buffer
);



#endif
#include "ipc.h"

#include "screen.h"



void ipc_init()
{

    print("IPC AXOS active\n");

}



int ipc_send(
    int process_id,
    char* message
)
{

    return 0;

}



int ipc_receive(
    int process_id,
    char* buffer
)
{

    return 0;

}
#include "ipc.h"
user_process_init();
ipc_init();
kernel/
├── syscall_user.h
└── syscall_user.c
#ifndef SYSCALL_USER_H
#define SYSCALL_USER_H


void syscall_user_init();


int syscall_print(char* text);


int syscall_file_read(char* name);


int syscall_app_exit();



#endif
#include "syscall_user.h"

#include "screen.h"



void syscall_user_init()
{

    print("User syscalls AXOS active\n");

}



int syscall_print(char* text)
{

    print(text);


    return 0;

}



int syscall_file_read(char* name)
{

    return 0;

}



int syscall_app_exit()
{

    return 0;

}
#include "syscall_user.h"
ipc_init();
syscall_user_init();
kernel/
├── error.h
└── error.c
#ifndef ERROR_H
#define ERROR_H


void error_init();


void kernel_error(char* message);



#endif
#include "error.h"

#include "screen.h"



void error_init()
{

    print("AXOS Error system active\n");

}



void kernel_error(char* message)
{

    print("ERROR: ");

    print(message);

    print("\n");


}
#include "error.h"
syscall_user_init();
error_init();
user/
├── shell_user.h
└── shell_user.c
#ifndef SHELL_USER_H
#define SHELL_USER_H


void shell_start();


void shell_command(char* command);



#endif
#include "shell_user.h"

#include "../kernel/syscall_user.h"



void shell_start()
{

    syscall_print("AXOS User Shell\n");


}



void shell_command(char* command)
{

    syscall_print("Commande : ");

    syscall_print(command);

}
#include "../user/shell_user.h"
terminal_init();
shell_start();
tools/
└── axac.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



int main(int argc, char** argv)
{

    if(argc < 3)
    {

        printf("Usage: axac input output.axa\n");

        return 1;

    }



    FILE* input;

    FILE* output;



    input = fopen(argv[1], "rb");


    if(input == NULL)
    {

        printf("Fichier source introuvable\n");

        return 1;

    }



    output = fopen(argv[2], "wb");


    if(output == NULL)
    {

        printf("Impossible de creer AXA\n");

        fclose(input);

        return 1;

    }



    char buffer[1024];

    int size;



    while((size = fread(buffer,1,1024,input)) > 0)
    {

        fwrite(buffer,1,size,output);

    }



    fclose(input);

    fclose(output);



    printf("Application AXA creee\n");


    return 0;

}
tools/
├── axac.c
└── Makefile
all:
	gcc axac.c -o axac
make
./axac hello.c hello.axa
kernel/
├── axa_format.h
└── axa_format.c
#ifndef AXA_FORMAT_H
#define AXA_FORMAT_H


#define AXA_MAGIC "AXA1"



typedef struct
{

    char magic[4];

    unsigned int version;

    unsigned int size;

    unsigned int entry;


} AXAHeader;



int axa_check(AXAHeader* header);



#endif
#include "axa_format.h"



int axa_check(AXAHeader* header)
{

    if(header->magic[0] == 'A' &&
       header->magic[1] == 'X' &&
       header->magic[2] == 'A')
    {

        return 1;

    }


    return 0;

}
kernel/axa_loader.c
#include "axa_format.h"
AXAHeader* header;

header = (AXAHeader*)program;


if(axa_check(header) == 0)
{

    print("Format AXA invalide\n");

    return -1;

}
tools/
└── axac.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



typedef struct
{

    char magic[4];

    unsigned int version;

    unsigned int size;

    unsigned int entry;


} AXAHeader;




int main(int argc, char** argv)
{

    if(argc < 3)
    {

        printf("Usage: axac source.c output.axa\n");

        return 1;

    }



    FILE* input;

    FILE* output;



    input = fopen(argv[1], "rb");


    if(input == NULL)
    {

        printf("Source introuvable\n");

        return 1;

    }



    output = fopen(argv[2], "wb");


    if(output == NULL)
    {

        printf("Creation impossible\n");

        fclose(input);

        return 1;

    }



    fseek(input,0,SEEK_END);


    unsigned int size = ftell(input);


    rewind(input);



    AXAHeader header;



    header.magic[0]='A';

    header.magic[1]='X';

    header.magic[2]='A';

    header.magic[3]='1';



    header.version = 1;


    header.size = size;


    header.entry = sizeof(AXAHeader);



    fwrite(
        &header,
        sizeof(AXAHeader),
        1,
        output
    );



    char buffer[1024];

    int read;



    while((read=fread(buffer,1,1024,input)) > 0)
    {

        fwrite(buffer,1,read,output);

    }



    fclose(input);

    fclose(output);



    printf("AXA cree avec succes\n");


    return 0;

}
make
./axac hello.c hello.axa
kernel/
├── app_loader.h
└── app_loader.c
#ifndef APP_LOADER_H
#define APP_LOADER_H


int app_load(char* filename);



#endif
#include "app_loader.h"

#include "filesystem.h"

#include "screen.h"

#include "axa_format.h"



#define APP_MEMORY 0x100000



int app_load(char* filename)
{

    char* file;


    file = read_file(filename);



    if(file == 0)
    {

        print("Application absente\n");

        return -1;

    }



    AXAHeader* header;


    header = (AXAHeader*)file;



    if(axa_check(header) == 0)
    {

        print("AXA invalide\n");

        return -1;

    }



    print("Chargement AXA...\n");



    void (*entry)();



    entry = (void (*)())
    (
        file + header->entry
    );



    entry();



    return 0;

}
kernel/app_manager.c
#include "app_loader.h"
int app_run(char* name)
{

    return app_load(name);

}
kernel/scheduler.c
#include "scheduler.h"

#include "screen.h"



#define MAX_TASKS 32



typedef void (*Task)();



Task tasks[MAX_TASKS];

int task_count = 0;

int current = 0;



void scheduler_init()
{

    task_count = 0;

    current = 0;

    print("Scheduler AXOS ready\n");

}



void scheduler_add(Task t)
{

    if(task_count < MAX_TASKS)
    {

        tasks[task_count] = t;

        task_count++;

    }

}



void scheduler_run()
{

    while(1)
    {

        if(task_count > 0)
        {

            tasks[current]();


            current++;


            if(current >= task_count)
            {

                current = 0;

            }

        }

    }

}
kernel/
├── process_manager.h
└── process_manager.c
#ifndef PROCESS_MANAGER_H
#define PROCESS_MANAGER_H


int process_create(void (*entry)());


void process_kill(int id);


void process_init();



#endif
#include "process_manager.h"

#include "scheduler.h"

#include "screen.h"



#define MAX_PROC 32



typedef struct
{

    void (*entry)();

    int active;


} Process;



Process processes[MAX_PROC];

int proc_count = 0;



void process_init()
{

    proc_count = 0;

    print("Process manager ready\n");

}



int process_create(void (*entry)())
{

    if(proc_count >= MAX_PROC)
    {

        return -1;

    }



    processes[proc_count].entry = entry;

    processes[proc_count].active = 1;



    scheduler_add(entry);



    proc_count++;


    return proc_count - 1;

}



void process_kill(int id)
{

    if(id < proc_count)
    {

        processes[id].active = 0;

    }

}
kernel/app_loader.c
#include "process_manager.h"
entry();
process_create(entry);
#include "process_manager.h"
#include "scheduler.h"
process_init();
scheduler_init();
process_init();
kernel/process_manager.h
#ifndef PROCESS_MANAGER_H
#define PROCESS_MANAGER_H


#define MAX_PROC 32



typedef struct
{

    int id;

    void (*entry)();

    int active;

    void* memory_start;

    unsigned int memory_size;


} Process;



int process_create(void (*entry)());


void process_kill(int id);


void process_init();



Process* process_get_current();



#endif
kernel/process_manager.c
#include "process_manager.h"

#include "scheduler.h"

#include "screen.h"



Process processes[MAX_PROC];

int proc_count = 0;

int current_process = -1;



void process_init()
{

    proc_count = 0;

    current_process = -1;

    print("Process manager ready (isolated mode)\n");

}



Process* process_get_current()
{

    if(current_process < 0)
    {

        return 0;

    }


    return &processes[current_process];

}



int process_create(void (*entry)())
{

    if(proc_count >= MAX_PROC)
    {

        return -1;

    }



    processes[proc_count].id = proc_count;

    processes[proc_count].entry = entry;

    processes[proc_count].active = 1;



    // mémoire simulée (future vraie allocation)

    processes[proc_count].memory_start = (void*)(0x100000 + proc_count * 0x10000);

    processes[proc_count].memory_size = 0x10000;



    scheduler_add(entry);



    proc_count++;


    return proc_count - 1;

}



void process_kill(int id)
{

    if(id < proc_count)
    {

        processes[id].active = 0;

    }

}
kernel/scheduler.c
current_process = current;

tasks[current]();
kernel/syscall_user.c
#include "process_manager.h"
#include "error.h"
int syscall_print(char* text)
{

    Process* p = process_get_current();


    if(p == 0 || p->active == 0)
    {

        kernel_error("Syscall depuis process invalide");

        return -1;

    }


    print(text);


    return 0;

}
int syscall_file_read(char* name)
{

    Process* p = process_get_current();


    if(p == 0 || p->active == 0)
    {

        kernel_error("File syscall invalide");

        return 0;

    }


    return 0;

}
int syscall_app_exit()
{

    Process* p = process_get_current();


    if(p == 0)
    {

        kernel_error("Exit syscall invalide");

        return -1;

    }


    process_kill(p->id);


    return 0;

}
int syscall_app_exit()
{

    Process* p = process_get_current();


    if(p == 0)
    {

        kernel_error("Exit syscall invalide");

        return -1;

    }


    process_kill(p->id);


    return 0;

kernel/
├── memory_manager.h
└── memory_manager.c
#ifndef MEMORY_MANAGER_H
#define MEMORY_MANAGER_H


void memory_manager_init();


void* kmalloc(unsigned int size);


void kfree(void* ptr);



#endif
#include "memory_manager.h"

#include "screen.h"



#define HEAP_SIZE 1048576



static unsigned char heap[HEAP_SIZE];

static unsigned int offset = 0;



void memory_manager_init()
{

    offset = 0;

    print("Memory manager ready\n");

}



void* kmalloc(unsigned int size)
{

    if(offset + size >= HEAP_SIZE)
    {

        return 0;

    }


    void* ptr = &heap[offset];


    offset += size;


    return ptr;

}



void kfree(void* ptr)
{

    // version simple : pas de free réel (heap linéaire)

}
#include "memory_manager.h"
memory_manager_init();
memory_init();
vmemory_init();
processes[proc_count].memory_start = kmalloc(0x10000);
#include "memory_manager.h"
kernel/memory_manager.h
#ifndef MEMORY_MANAGER_H
#define MEMORY_MANAGER_H


void memory_manager_init();


void* kmalloc(unsigned int size);


void kfree(void* ptr);



#endif
kernel/memory_manager.c
#include "memory_manager.h"

#include "screen.h"



#define HEAP_SIZE 1048576

#define MAX_BLOCKS 1024



typedef struct
{

    void* ptr;

    unsigned int size;

    int free;


} Block;



static unsigned char heap[HEAP_SIZE];

static Block blocks[MAX_BLOCKS];

static int block_count = 0;



void memory_manager_init()
{

    block_count = 0;


    print("Memory manager (blocks) ready\n");

}



void* kmalloc(unsigned int size)
{

    if(block_count >= MAX_BLOCKS)
    {

        return 0;

    }



    void* ptr = 0;



    if(block_count == 0)
    {

        ptr = heap;


    }
    else
    {

        Block* last = &blocks[block_count - 1];


        ptr = (void*)((unsigned char*)last->ptr + last->size);

    }



    if((unsigned char*)ptr + size - heap > HEAP_SIZE)
    {

        return 0;

    }



    blocks[block_count].ptr = ptr;

    blocks[block_count].size = size;

    blocks[block_count].free = 0;



    block_count++;


    return ptr;

}



void kfree(void* ptr)
{

    for(int i = 0; i < block_count; i++)
    {

        if(blocks[i].ptr == ptr)
        {

            blocks[i].free = 1;

            return;

        }

    }

}
kernel/
├── keyboard.h
└── keyboard.c
#ifndef KEYBOARD_H
#define KEYBOARD_H


void keyboard_init();


char keyboard_get();


void keyboard_push(char c);



#endif
#include "keyboard.h"

#include "screen.h"



#define BUFFER_SIZE 128



static char buffer[BUFFER_SIZE];

static int read_index = 0;

static int write_index = 0;



void keyboard_init()
{

    read_index = 0;

    write_index = 0;

    print("Keyboard ready\n");

}



void keyboard_push(char c)
{

    buffer[write_index] = c;


    write_index++;


    if(write_index >= BUFFER_SIZE)
    {

        write_index = 0;

    }

}



char keyboard_get()
{

    if(read_index == write_index)
    {

        return 0;

    }


    char c = buffer[read_index];


    read_index++;


    if(read_index >= BUFFER_SIZE)
    {

        read_index = 0;

    }


    return c;

}
kernel/input.c
#include "input.h"

#include "keyboard.h"



static char line[128];

static int index = 0;



char* input_read()
{

    char c;


    index = 0;



    while(1)
    {

        c = keyboard_get();


        if(c == 0)
        {

            continue;

        }


        if(c == '\n')
        {

            line[index] = 0;

            return line;

        }


        if(index < 127)
        {

            line[index] = c;

            index++;

        }

    }

}
#include "keyboard.h"
keyboard_init();
kernel/process_manager.c
#include "memory_manager.h"
#include "error.h"
void process_kill(int id)
void process_kill(int id)
{

    if(id < 0 || id >= proc_count)
    {

        kernel_error("Process kill invalide");

        return;

    }



    if(processes[id].active == 0)
    {

        return;

    }



    processes[id].active = 0;



    if(processes[id].memory_start != 0)
    {

        kfree(processes[id].memory_start);

        processes[id].memory_start = 0;

    }



    print("Process killed + memory freed\n");

}
kernel/syscall_user.c
#include "process_manager.h"



int syscall_app_exit()
{

    Process* p = process_get_current();


    if(p == 0)
    {

        kernel_error("Exit sans process");

        return -1;

    }


    process_kill(p->id);


    return 0;

}
kernel/scheduler.c
if(tasks[current] == 0)
{
    continue;
}
kernel/
├── framebuffer.h
└── framebuffer.c
#ifndef FRAMEBUFFER_H
#define FRAMEBUFFER_H


void fb_init();


void fb_clear(unsigned int color);


void fb_draw_pixel(int x, int y, unsigned int color);



#endif
#include "framebuffer.h"



#define WIDTH 800

#define HEIGHT 600



static unsigned int* fb = (unsigned int*)0xA0000;



void fb_init()
{

}



void fb_clear(unsigned int color)
{

    for(int y = 0; y < HEIGHT; y++)
    {

        for(int x = 0; x < WIDTH; x++)
        {

            fb[y * WIDTH + x] = color;

        }

    }

}



void fb_draw_pixel(int x, int y, unsigned int color)
{

    if(x < 0 || y < 0 || x >= WIDTH || y >= HEIGHT)
    {

        return;

    }


    fb[y * WIDTH + x] = color;

}
kernel/
├── gui_event.h
└── gui_event.c
#ifndef GUI_EVENT_H
#define GUI_EVENT_H


typedef struct
{

    int type;

    int x;

    int y;

    int key;


} GUIEvent;



#define EVENT_NONE 0

#define EVENT_MOUSE_CLICK 1

#define EVENT_KEY_PRESS 2



void gui_event_init();


void gui_event_push(GUIEvent e);


int gui_event_pop(GUIEvent* e);



#endif
#include "gui_event.h"



#define MAX_EVENTS 64



static GUIEvent events[MAX_EVENTS];

static int read_index = 0;

static int write_index = 0;



void gui_event_init()
{

    read_index = 0;

    write_index = 0;

}



void gui_event_push(GUIEvent e)
{

    events[write_index] = e;


    write_index++;


    if(write_index >= MAX_EVENTS)
    {

        write_index = 0;

    }

}



int gui_event_pop(GUIEvent* e)
{

    if(read_index == write_index)
    {

        return 0;

    }


    *e = events[read_index];


    read_index++;


    if(read_index >= MAX_EVENTS)
    {

        read_index = 0;

    }


    return 1;

}
#include "gui_event.h"
gui_event_init();
#include "gui_event.h"
GUIEvent e;

e.type = EVENT_KEY_PRESS;

e.key = c;


gui_event_push(e);
#include "gui_event.h"
GUIEvent e;

e.type = EVENT_MOUSE_CLICK;

e.x = x;

e.y = y;


gui_event_push(e);
GUIEvent e;
kernel/window_manager.h
#ifndef WINDOW_MANAGER_H
#define WINDOW_MANAGER_H


typedef struct
{

    int x;

    int y;

    int w;

    int h;

    int active;

    int focused;


} Window;



void window_manager_init();


int window_create(int x, int y, int w, int h);


void window_focus(int id);


void window_handle_click(int x, int y);



void window_render();



#endif
kernel/window_manager.c
#include "window_manager.h"

#include "screen.h"

#include "gui_event.h"



#define MAX_WINDOWS 16



static Window windows[MAX_WINDOWS];

static int window_count = 0;

static int focused_window = -1;



void window_manager_init()
{

    window_count = 0;

    focused_window = -1;


    print("Window Manager interactive ready\n");

}



int window_create(int x, int y, int w, int h)
{

    if(window_count >= MAX_WINDOWS)
    {

        return -1;

    }



    windows[window_count].x = x;

    windows[window_count].y = y;

    windows[window_count].w = w;

    windows[window_count].h = h;

    windows[window_count].active = 1;

    windows[window_count].focused = 0;



    window_count++;


    return window_count - 1;

}



void window_focus(int id)
{

    if(id < 0 || id >= window_count)
    {

        return;

    }



    for(int i = 0; i < window_count; i++)
    {

        windows[i].focused = 0;

    }



    windows[id].focused = 1;

    focused_window = id;

}



void window_handle_click(int x, int y)
{

    for(int i = 0; i < window_count; i++)
    {

        Window* w = &windows[i];


        if(x >= w->x && x <= w->x + w->w &&
           y >= w->y && y <= w->y + w->h)
        {

            window_focus(i);

            return;

        }

    }

}



void window_render()
{

    for(int i = 0; i < window_count; i++)
    {

        Window* w = &windows[i];


        if(w->active)
        {

            if(w->focused)
            {

                print("Window focused\n");

            }

        }

    }

}
#include "gui_event.h"
#include "window_manager.h"
GUIEvent e;



while(gui_event_pop(&e))
{

    if(e.type == EVENT_MOUSE_CLICK)
    {

        window_handle_click(e.x, e.y);

    }

}
#include "window_manager.h"
window_create(100, 100, 200, 150);

window_create(350, 200, 200, 150);
kernel/window_manager.h
int dragging;

int drag_offset_x;

int drag_offset_y;
typedef struct
{

    int x;

    int y;

    int w;

    int h;

    int active;

    int focused;

    int dragging;

    int drag_offset_x;

    int drag_offset_y;


} Window;
window_manager.c
void window_handle_click(int x, int y)
{

    for(int i = 0; i < window_count; i++)
    {

        Window* w = &windows[i];


        if(x >= w->x && x <= w->x + w->w &&
           y >= w->y && y <= w->y + w->h)
        {

            window_focus(i);



            w->dragging = 1;


            w->drag_offset_x = x - w->x;

            w->drag_offset_y = y - w->y;


            return;

        }

    }

}
void window_handle_mouse_move(int x, int y)
{

    for(int i = 0; i < window_count; i++)
    {

        Window* w = &windows[i];


        if(w->dragging)
        {

            w->x = x - w->drag_offset_x;

            w->y = y - w->drag_offset_y;

        }

    }

}
void window_handle_mouse_release()
{

    for(int i = 0; i < window_count; i++)
    {

        windows[i].dragging = 0;

    }

}
while(gui_event_pop(&e))
{

    if(e.type == EVENT_MOUSE_CLICK)
    {

        window_handle_click(e.x, e.y);

    }


    if(e.type == EVENT_KEY_PRESS)
    {

        // rien pour l’instant
    }

}
#define EVENT_MOUSE_MOVE 3

#define EVENT_MOUSE_RELEASE 4
if(e.type == EVENT_MOUSE_MOVE)
{

    window_handle_mouse_move(e.x, e.y);

}



if(e.type == EVENT_MOUSE_RELEASE)
{

    window_handle_mouse_release();

}
GUIEvent e;

e.type = EVENT_MOUSE_MOVE;

e.x = x;

e.y = y;

gui_event_push(e);
GUIEvent e;

e.type = EVENT_MOUSE_RELEASE;

gui_event_push(e);
GUIEvent e;

e.type = EVENT_MOUSE_RELEASE;

gui_event_push(e);
user/axa_app.h
#ifndef AXA_APP_H
#define AXA_APP_H


typedef struct
{

    int window_id;

    void (*draw)();

    void (*update)();


} AXAApp;



int axa_app_launch(AXAApp app);



#endif
#ifndef AXA_APP_H
#define AXA_APP_H


typedef struct
{

    int window_id;

    void (*draw)();

    void (*update)();


} AXAApp;



int axa_app_launch(AXAApp app);



#endif
user/axa_app.c
#include "axa_app.h"

#include "../kernel/window_manager.h"

#include "../kernel/process_manager.h"



int axa_app_launch(AXAApp app)
{

    int win = window_create(150, 150, 300, 200);


    if(win < 0)
    {

        return -1;

    }



    app.window_id = win;



    process_create(app.update);


    return win;

}
user/apps/hello_gui.c
#include "../axa_app.h"

#include "../../kernel/screen.h"



AXAApp app;



void hello_draw()
{

    print("Hello AXOS GUI App\n");

}



void hello_update()
{

    hello_draw();

}



AXAApp get_app()
{

    app.draw = hello_draw;

    app.update = hello_update;


    return app;

}
AXAApp app = get_app();

axa_app_launch(app);
kernel/gui_event.h
#define EVENT_MOUSE_DOUBLE_CLICK 5
kernel/desktop.h
typedef struct
{

    int x;

    int y;

    char name[32];

} Icon;



void desktop_add_icon(int x, int y, char* name);


void desktop_handle_click(int x, int y);


kernel/desktop.c
#include "desktop.h"

#include "window_manager.h"

#include "app_loader.h"

#include "screen.h"



#define MAX_ICONS 16



static Icon icons[MAX_ICONS];

static int icon_count = 0;



void desktop_add_icon(int x, int y, char* name)
{

    icons[icon_count].x = x;

    icons[icon_count].y = y;



    int i = 0;

    while(name[i] && i < 31)
    {

        icons[icon_count].name[i] = name[i];

        i++;

    }


    icons[icon_count].name[i] = 0;


    icon_count++;

}
void desktop_handle_click(int x, int y)
{

    for(int i = 0; i < icon_count; i++)
    {

        Icon* ic = &icons[i];


        if(x >= ic->x && x <= ic->x + 50 &&
           y >= ic->y && y <= ic->y + 50)
        {

            print("Lancement app AXA...\n");


            app_load(ic->name);

            return;

        }

    }

}
#include "desktop.h"
if(e.type == EVENT_MOUSE_DOUBLE_CLICK)
{

    desktop_handle_click(e.x, e.y);

}
static int last_click_time = 0;



if(click_detected)
{

    if(time_now - last_click_time < 20)
    {

        GUIEvent e;

        e.type = EVENT_MOUSE_DOUBLE_CLICK;

        e.x = x;

        e.y = y;


        gui_event_push(e);

    }


    last_click_time = time_now;

}
desktop_add_icon(100, 100, "hello.axa");

desktop_add_icon(200, 100, "calc.axa");
user/ui.h
user/ui.c
#ifndef UI_H
#define UI_H


typedef struct
{

    int x;

    int y;

    int w;

    int h;

    char text[32];

    int pressed;


} UIButton;



void ui_draw_button(UIButton* b);


int ui_button_click(UIButton* b, int mx, int my);



#endif
#include "ui.h"

#include "../kernel/screen.h"



void ui_draw_button(UIButton* b)
{

    print("[BUTTON] ");

    print(b->text);

    print("\n");

}



int ui_button_click(UIButton* b, int mx, int my)
{

    if(mx >= b->x && mx <= b->x + b->w &&
       my >= b->y && my <= b->y + b->h)
    {

        b->pressed = 1;

        return 1;

    }


    return 0;

}
kernel/window_manager.h
void window_render_ui(int id);
kernel/window_manager.c
#include "../user/ui.h"



void window_render_ui(int id)
{

    if(id < 0 || id >= window_count)
    {

        return;

    }



    UIButton btn;



    btn.x = 20;

    btn.y = 20;

    btn.w = 80;

    btn.h = 30;



    int i = 0;

    char text[] = "OK";


    while(text[i])
    {

        btn.text[i] = text[i];

        i++;

    }


    btn.text[i] = 0;



    btn.pressed = 0;



    ui_draw_button(&btn);

}
window_render_ui(i);
filesystem/
├── disk.h
└── disk.c
#ifndef DISK_H
#define DISK_H


void disk_init();


int disk_read(int sector, void* buffer);


int disk_write(int sector, void* buffer);



#endif
#include "disk.h"

#include "../kernel/screen.h"



#define DISK_SIZE 1024



static unsigned char disk[DISK_SIZE * 512];



void disk_init()
{

    print("Disk initialized (virtual)\n");

}



int disk_read(int sector, void* buffer)
{

    if(sector < 0 || sector >= DISK_SIZE)
    {

        return -1;

    }



    char* src = &disk[sector * 512];

    char* dst = (char*)buffer;



    for(int i = 0; i < 512; i++)
    {

        dst[i] = src[i];

    }



    return 0;

}



int disk_write(int sector, void* buffer)
{

    if(sector < 0 || sector >= DISK_SIZE)
    {

        return -1;

    }



    char* dst = &disk[sector * 512];

    char* src = (char*)buffer;



    for(int i = 0; i < 512; i++)
    {

        dst[i] = src[i];

    }



    return 0;

}
filesystem/file.c
#include "disk.h"
typedef struct
{

    char name[32];

    int sector;

    int size;


} FileEntry;



static FileEntry files[128];

static int file_count = 0;
int file_create(char* name)
{

    files[file_count].sector = file_count + 1;

    files[file_count].size = 0;



    int i = 0;

    while(name[i] && i < 31)
    {

        files[file_count].name[i] = name[i];

        i++;

    }


    files[file_count].name[i] = 0;


    file_count++;


    return 0;

}
int file_write(char* name, char* data)
{

    for(int i = 0; i < file_count; i++)
    {

        if(files[i].name[0] == name[0])
        {

            disk_write(files[i].sector, data);

            return 0;

        }

    }


    return -1;

}
char* file_read(char* name)
{

    static char buffer[512];


    for(int i = 0; i < file_count; i++)
    {

        if(files[i].name[0] == name[0])
        {

            disk_read(files[i].sector, buffer);

            return buffer;

        }

    }


    return 0;

}
#include "../filesystem/disk.h"
disk_init();
user/ui.h
typedef struct
{

    int x;

    int y;

    int w;

    int h;

    char buffer[64];

    int index;

    int active;


} UITextBox;



void ui_draw_textbox(UITextBox* t);


void ui_textbox_input(UITextBox* t, char key);


int ui_textbox_click(UITextBox* t, int mx, int my);
#include "ui.h"

#include "../kernel/screen.h"



void ui_draw_textbox(UITextBox* t)
{

    print("[INPUT] ");

    print(t->buffer);

    print("\n");

}



int ui_textbox_click(UITextBox* t, int mx, int my)
{

    if(mx >= t->x && mx <= t->x + t->w &&
       my >= t->y && my <= t->y + t->h)
    {

        t->active = 1;

        return 1;

    }


    t->active = 0;

    return 0;

}



void ui_textbox_input(UITextBox* t, char key)
{

    if(!t->active)
    {

        return;

    }



    if(key == '\n')
    {

        t->buffer[t->index] = 0;

        return;

    }



    if(t->index < 63)
    {

        t->buffer[t->index] = key;

        t->index++;

        t->buffer[t->index] = 0;

    }

}
window_manager.c
#include "../user/ui.h"
UITextBox box;



box.x = 20;

box.y = 60;

box.w = 120;

box.h = 30;

box.index = 0;

box.active = 0;



ui_draw_textbox(&box);
static UITextBox global_box;



ui_textbox_input(&global_box, e.key);
ui_textbox_click(&global_box, e.x, e.y);