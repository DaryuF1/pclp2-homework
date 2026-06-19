// Udroiu Darius-Adrian, 312CB
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
int main(void)
{
    int n, m;
    if (scanf("%d %d", &n, &m) != 2)
        return 0;
    uint32_t *f = malloc(5*sizeof(uint32_t)); // alocam un vector pt. categorii, de la 1 la 4
    if (!f){
        printf("Eroare de alocare"); // daca nu s a putut aloca printam eroare si iesim din program
		return 0;
    }
    int i = 0;
make_0:  // facem elementele vectorului nule cu un loop
    if(i==5)
        goto solve;
    f[i] = 0;
    i++;
    goto make_0;
solve:
    i = 0;
loop: // rezolvam tasku
    if(i==n)
        goto end;
uint32_t t;
if (scanf("%i", &t) != 1) 
    goto end;

    uint8_t luna = (t >> 24) & 0xFF, // extragem primii 8 biti care reprezinta luna
            cat = (t >> 8) & 0xFF, // extragem urmatorii 8 biti care reprezinta categoria
            suma = t & 0xFF; // extragem ultimii 8 biti care reprezinta suma
    if(luna == m){
        if(cat >=1 && cat <=4){
            f[cat] += suma; // daca luna extrasa coincide cu m, adunam suma la categoria corespunzatoare
        }
    }
    i++;
    goto loop;
end:
    i = 1;
print:
    if(i==5){
        free(f); // daca am ajuns la final eliberam memoria si iesim din program
        exit(0);
    }
    
    printf("%d: %u\n",i,f[i]); // afisam suma totala pt. fiecare categorie
    i++;
    goto print;
    return 0;
}