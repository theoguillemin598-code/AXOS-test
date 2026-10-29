#include "heap.h"

static struct block_header* heap_start = (struct block_header*)0;

void heap_init(unsigned int start_address, unsigned int size) {
    heap_start = (struct block_header*)start_address;
    heap_start->size = size - sizeof(struct block_header);
    heap_start->is_free = 1;
    heap_start->next = (void*)0;
}
#include "heap.h"

static struct block_header* heap_start = (struct block_header*)0;

void heap_init(unsigned int start_address, unsigned int size) {
    heap_start = (struct block_header*)start_address;
    heap_start->size = size - sizeof(struct block_header);
    heap_start->is_free = 1;
    heap_start->next = (struct block_header*)0;
}

void* kmalloc(unsigned int size) {
    struct block_header* current = heap_start;

    // Parcourt la liste des blocs pour trouver le premier bloc libre assez grand
    while (current != (struct block_header*)0) {
        if (current->is_free && current->size >= size) {
            current->is_free = 0; // Marque le bloc comme occupé
            
            // Retourne l'adresse située juste après l'en-tête du bloc
            return (void*)((unsigned int)current + sizeof(struct block_header));
        }
        current = current->next;
    }
    
    return (void*)0; // Échec : plus assez de mémoire dans le tas
}

void kfree(void* ptr) {
    if (!ptr) return;

    // Retrouve l'en-tête du bloc en reculant de la taille du header
    struct block_header* header = (struct block_header*)((unsigned int)ptr - sizeof(struct block_header));
    header->is_free = 1; // Marque le bloc comme libre à nouveau
}
set timeout=0
set default=0

menuentry "AXOS" {
    multiboot /boot/kernel.bin
    module /boot/initrd.img   # C'est ton RAM disk !
    boot
}
    