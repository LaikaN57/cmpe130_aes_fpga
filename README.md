# cmpe130_aes_fpga
This project implements the AES256 algorithm on an FPGA. Specifically we are using a Digilent Nexys 3 or 4. The SPI module should basically shift in the key and input (plaintext/ciphertext) then shift out the corresponding output. An additional line is used to select the encrypt or decrypt mode.
## ToDos
* Sanity check KeyExpansion module
* Sanity check SPI module
* Implement SPI module in top module
* Create AES_encrypt/decrypt testbenches
