; 88x31 button, this was mostly taken from favicon.asm
; I feel like the novelty of an image created with an assembler is gone to me at
; this point, but I refuse to use anything other than MS paint and I also refuse
; to use Windows. It's a real problem.

; NOTE TO SELF: There are some hard-coded numbers in library.c, change those if
; you're changing these

bmp_header:
  db "BM"                      ; Magic number
  dd bmp_end - bmp_header      ; File size
  dw 0                         ; Reserved
  dw 0                         ; Reserved
  dd img_data - bmp_header     ; Initial data location

dib_header:
  dd color_table - dib_header  ; Size of DIB header
  dd 88                        ; Width
  dd 31                        ; Height
  dw 1                         ; No. of color planes
  dw 1                         ; Bits per pixel

color_table:
  db 0x00, 0xff, 0x00, 0x00   ; "white"
  db 0x00, 0x00, 0x00, 0x00   ; "black"

img_data:

; Through a happy accident of design, I've created two new natechoe.dev mascots.
; Meet Nate and choedev. Nate is the kid from Texas who likes computers.
; choedev is a chronically online gremlin who makes images with assemblers.
  db 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0
  db 0b10000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001, 0
  db 0b10000111, 0b11111111, 0b11111000, 0b00011111, 0b11100001, 0b00000010, 0b00011111, 0b11100001, 0b11111110, 0b00000000, 0b00000001, 0
  db 0b10000100, 0b00000000, 0b00001000, 0b00010000, 0b00000001, 0b00000010, 0b00010000, 0b00100001, 0b00000000, 0b00000000, 0b00000001, 0
  db 0b10000010, 0b10000000, 0b01000100, 0b00001000, 0b00000000, 0b10000001, 0b00001000, 0b00010000, 0b10000000, 0b00000000, 0b00000001, 0
  db 0b10000010, 0b01111111, 0b11100100, 0b00001000, 0b00000000, 0b10000001, 0b00001000, 0b00010000, 0b10000000, 0b00000000, 0b00000001, 0
  db 0b10000001, 0b00000000, 0b00000010, 0b00000100, 0b00000000, 0b01000000, 0b10000100, 0b00001000, 0b01000000, 0b00000000, 0b00000001, 0
  db 0b10000001, 0b00111100, 0b11110010, 0b00000100, 0b00000000, 0b01000000, 0b10000100, 0b00001000, 0b01000000, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b10010010, 0b01001001, 0b00000010, 0b00000000, 0b00111111, 0b11000010, 0b00000100, 0b00111111, 0b11000000, 0b00000001, 0
  db 0b10000000, 0b10011110, 0b01111001, 0b00000010, 0b00000000, 0b00100000, 0b01000010, 0b00000100, 0b00100000, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b01001111, 0b00111100, 0b10000001, 0b00000000, 0b00010000, 0b00100001, 0b00000010, 0b00010000, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b01001111, 0b00111100, 0b10000001, 0b00000000, 0b00010000, 0b00100001, 0b00000010, 0b00010000, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00100000, 0b00000000, 0b01000000, 0b10000000, 0b00001000, 0b00010000, 0b10000001, 0b00001000, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00111111, 0b11111111, 0b11000000, 0b11111111, 0b00001000, 0b00010000, 0b11111111, 0b00001111, 0b11110000, 0b00000001, 0
  db 0b10000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00000111, 0b11111111, 0b11111000, 0b01000000, 0b10000100, 0b00001000, 0b00000100, 0b00000111, 0b11111000, 0b00000001, 0
  db 0b10000000, 0b00000100, 0b00000000, 0b00001000, 0b01000000, 0b10000100, 0b00001000, 0b00000100, 0b00000100, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00000010, 0b01111111, 0b11100100, 0b00100000, 0b11000010, 0b00000100, 0b00000010, 0b00000010, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00000010, 0b01000000, 0b00100100, 0b00100000, 0b11000010, 0b00000100, 0b00000010, 0b00000010, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00000001, 0b00000000, 0b00000010, 0b00010001, 0b00100001, 0b00000010, 0b00000001, 0b00000001, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00000001, 0b00000000, 0b00000010, 0b00010001, 0b00100001, 0b00000010, 0b00000001, 0b00000001, 0b00000000, 0b00000001, 0
  db 0b10000000, 0b00000000, 0b10011110, 0b01111001, 0b00001001, 0b00010000, 0b11111111, 0b00000000, 0b10000000, 0b11111111, 0b00000001, 0
  db 0b10000000, 0b00000000, 0b10010010, 0b01001001, 0b00001001, 0b00010000, 0b10000001, 0b00000000, 0b10000000, 0b10000000, 0b00000001, 0
  db 0b10000000, 0b00000000, 0b01001001, 0b00100100, 0b10000110, 0b00001000, 0b01000000, 0b10000000, 0b01000000, 0b01000000, 0b00000001, 0
  db 0b10000000, 0b00000000, 0b01001111, 0b00111100, 0b10000110, 0b00001000, 0b01000000, 0b10000000, 0b01000000, 0b01000000, 0b00000001, 0
  db 0b10000000, 0b00000000, 0b00100000, 0b00000000, 0b01000010, 0b00000100, 0b00100000, 0b01000000, 0b00100000, 0b00100000, 0b00000001, 0
  db 0b10000000, 0b00000000, 0b00111111, 0b11111111, 0b11000010, 0b00000100, 0b00111111, 0b11000011, 0b11111100, 0b00111111, 0b11000001, 0
  db 0b10000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000001, 0
  db 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0b11111111, 0

; Early draft of the natechoe.dev 88x31 button
; This would get converted into a real favicon by a vim command
;  db 0b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1000001111111100001000000100001111111100001111111100000000000000000000000000000000000001, 0
;  db 0b1000001000000000001000000100001000000100001000000000000000000000000000000000000000000001, 0
;  db 0b1000000100000000000100000010000100000010000100000000000000000000000000000000000000000001, 0
;  db 0b1000000100000000000100000010000100000010000100000000000000000000000000000000000000000001, 0
;  db 0b1000000010000000000010000001000010000001000010000000000000000000000000000000000000000001, 0
;  db 0b1000000010000000000010000001000010000001000010000000000000000000000000000000000000000001, 0
;  db 0b1000000001000000000001111111100001000000100001111111100000000000000000000000000000000001, 0
;  db 0b1000000001000000000001000000100001000000100001000000000000000000000000000000000000000001, 0
;  db 0b1000000000100000000000100000010000100000010000100000000000000000000000000000000000000001, 0
;  db 0b1000000000100000000000100000010000100000010000100000000000000000000000000000000000000001, 0
;  db 0b1000000000010000000000010000001000010000001000010000000000000000000000000000000000000001, 0
;  db 0b1000000000011111111000010000001000011111111000011111111000000000000000000000000000000001, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1000000000000000000000100000010000100000010000000010000000111111110000000000000000000001, 0
;  db 0b1000000000000000000000100000010000100000010000000010000000100000000000000000000000000001, 0
;  db 0b1000000000000000000000010000011000010000001000000001000000010000000000000000000000000001, 0
;  db 0b1000000000000000000000010000011000010000001000000001000000010000000000000000000000000001, 0
;  db 0b1000000000000000000000001000100100001000000100000000100000001000000000000000000000000001, 0
;  db 0b1000000000000000000000001000100100001000000100000000100000001000000000000000000000000001, 0
;  db 0b1000000000000000000000000100100010000111111110000000010000000111111110000000000000000001, 0
;  db 0b1000000000000000000000000100100010000100000010000000010000000100000000000000000000000001, 0
;  db 0b1000000000000000000000000011000001000010000001000000001000000010000000000000000000000001, 0
;  db 0b1000000000000000000000000011000001000010000001000000001000000010000000000000000000000001, 0
;  db 0b1000000000000000000000000001000000100001000000100000000100000001000000000000000000000001, 0
;  db 0b1000000000000000000000000001000000100001111111100001111111100001111111100000000000000001, 0
;  db 0b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000001, 0
;  db 0b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, 0

bmp_end:
