// Udroiu Darius-Adrian, 312CB
#include <stdio.h>
#include <stdint.h>

uint8_t reverse(uint8_t b) // functie care inverseaza bitii dintr un octet
{
    uint8_t ans = 0;
    int i = 0;
    loop:
    if(i>7)
         goto end;
    if((b>>i)&1)
        goto up;
    else
        goto inc;
up:
    ans |= (1<<(7-i)); // setam bitul in oglinda pt. ans
    goto inc;
inc:
    i++;
    goto loop;
end: 
    return ans;    
}
uint16_t encrypt_message(uint8_t msg, uint8_t key) 
{
    uint8_t x = (msg ^ key); // XOR intre mesaj si cheie
    uint8_t r = reverse(x);
    uint16_t idk = 0;
    int i = 7;

loop:
    if(i<0)
        goto end;
// extragem bitul i din rezultatul inversat si din cheie
    uint8_t mb = (r >> i) & 1;
    uint8_t kb = (key >> i) & 1;
    // adaugam bitul din mb in rezultat
    idk = (idk << 1) | mb;
// daca bitul din mesaj e egal cu cel din cheie adaugam bitul 1, altfel 0
    if(mb == kb)
        goto bit_one;
    else
        goto bit_zero;
bit_one:
    idk = (idk << 1) | 1;
    goto dec;
bit_zero:
    idk = (idk << 1) | 0;
    goto dec;
dec:
    i--;
    goto loop;        
 end:
 // inversam octetul superior cu cel inferior
    idk = (idk << 8) | (idk >> 8);
    return  idk;
}

int main()
{
    uint8_t key, msg;
   if(scanf("%hhx %hhx",&msg,&key) == 2){
    uint16_t ans = encrypt_message(msg,key);
    // afisam rezultatul
    printf("0x%04X",ans);
   }
    
    return 0;
}