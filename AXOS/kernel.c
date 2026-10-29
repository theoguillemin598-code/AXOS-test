#include "framebuffer.h"

void kernel_main(void* multiboot_structure) {
    // Rend l'arrière-plan en gris ardoise sombre
    fb_clear(COLOR_BACKGROUND);

    // Dessine une première fenêtre moderne au centre de l'écran
    fb_draw_rect(262, 184, 500, 300, COLOR_WINDOW_BG);  // Corps de fenêtre
    fb_draw_rect(262, 184, 500, 35,  COLOR_TITLEBAR);   // Barre de titre
    fb_draw_rect(272, 194, 15,  15,  0xF38BA8);          // Bouton fermer (Rouge pastel)
    fb_draw_rect(295, 194, 15,  15,  0xF9E2AF);          // Bouton réduire (Jaune pastel)
    fb_draw_rect(318, 194, 15,  15,  0xA6E3A1);          // Bouton agrandir (Vert pastel)

    while(1) {
        __asm__("hlt");
    }
}
