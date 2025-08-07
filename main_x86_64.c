#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void clear_screen() {
    printf("\033[H\033[J"); // ANSI escape code to clear the screen
}

void print_string(const char *str) {
    printf("%s", str);
}

void print_menu() {
    const char *menu_text = "Select OS to boot:\n1) Boot OS A\n2) Boot OS B\n";
    print_string(menu_text);
}

int main() {
    char choice;

    clear_screen();
    print_menu();

    while (1) {
        choice = getchar();
        if (choice == '1') {
            clear_screen();
            print_string("Booting OS A...\n");
            break;
        } else if (choice == '2') {
            clear_screen();
            print_string("Booting OS B...\n");
            break;
        }
    }

    return 0;
}
