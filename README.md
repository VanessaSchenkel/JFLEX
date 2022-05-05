# JFLEX
A simple lexical analyzer for C

## Installation

Install [jflex](https://https://jflex.de/).

## Usage

```bash
jflex lexical.jflex 
```
That will create a java file named LexicalAnalyzer (you can change it in the jflex file)

```bash
javac LexicalAnalyzer.java 
```
That will create a LexicalAnalyzer.class

```bash
java LexicalAnalyzer entrada.txt  
```
With this command you can run the class and the file. It will show in your terminal line by line of the lexical analyzer. 


```text
Scope methods has been added
[ID 0, Scope 0, Subscope 0,"main"]
<stdio.h> library will be imported
<stdio.h> library scope has been added
[ID 1, Scope 1, Subscope 0, "printf"] 
[ID 2, Scope 1, Subscope 0, "scanf"] 
<stdio.h> library scope has been imported
<conio.h> library will be imported
<conio.h> library scope has been added
[ID 3, Scope 2, Subscope 0, "clrscr"] 
[ID 4, Scope 2, Subscope 0, "getch"] 
<conio.h> library scope has been imported
[ID 5, Scope 0, Subscope 0, void]
[ID 6, Scope 3, Subscope 0, CalculoMedia]
[L_Paren, (]
[R_Paren, )]
[L_Brace, {]
[ID 7, Scope 3, Subscope 0, float]
[ID 8, Scope 3, Subscope 0, NotaDaP1]
[Comma, ,]
[ID 9, Scope 3, Subscope 0, NotaDaP2]
[Semicolon, ;]
[ID 7, Scope 3, Subscope 0, float]
[ID 10, Scope 3, Subscope 0, Media]
[Semicolon, ;]
[ID 11, Scope 3, Subscope 0, clrscr]
[L_Paren, (]
[R_Paren, )]
[Semicolon, ;]
[ID 8, Scope 3, Subscope 0, NotaDaP1]
[Equal, =]
[Float, 6.6]
[Semicolon, ;]
[ID 9, Scope 3, Subscope 0, NotaDaP2]
[Equal, =]
[Float, 8.2]
[Semicolon, ;]
[ID 10, Scope 3, Subscope 0, Media]
[Equal, =]
[L_Paren, (]
[ID 8, Scope 3, Subscope 0, NotaDaP1]
[Arith_Op: +]
[ID 9, Scope 3, Subscope 0, NotaDaP2]
[R_Paren, )]
[Arith_Op: /]
[Float, 2.0]
[Semicolon, ;]
[ID 12, Scope 3, Subscope 0, printf]
[L_Paren, (]
[String_literal, "Média Final : %6.3f"]
[Comma, ,]
[ID 10, Scope 3, Subscope 0, Media]
[R_Paren, )]
[Semicolon, ;]
[ID 4, Scope 2, Subscope 0, getch]
[L_Paren, (]
[R_Paren, )]
[Semicolon, ;]
[R_Brace, }]
[ID 13, Scope 0, Subscope 0, int]
[ID 14, Scope 4, Subscope 0, VerificaNumero]
[L_Paren, (]
[R_Paren, )]
[L_Brace, {]
[ID 13, Scope 0, Subscope 0, int]
[ID 15, Scope 4, Subscope 0, num]
[Semicolon, ;]
[ID 16, Scope 4, Subscope 0, string]
[ID 17, Scope 4, Subscope 0, s]
[Semicolon, ;]
[ID 18, Scope 4, Subscope 0, printf]
[L_Paren, (]
[String_literal, "Digite um número: "]
[R_Paren, )]
[Semicolon, ;]
[ID 2, Scope 1, Subscope 0, scanf]
[L_Paren, (]
[String_literal, "%d"]
[Comma, ,]
[Address, &]
[ID 15, Scope 4, Subscope 0, num]
[R_Paren, )]
[Semicolon, ;]
[ID 19, Scope 4, Subscope 0, if]
[L_Paren, (]
[ID 15, Scope 4, Subscope 0, num]
[Relational_Op, >]
[Digit, 10]
[R_Paren, )]
[L_Brace, {]
[ID 18, Scope 4, Subscope 0, printf]
[L_Paren, (]
[String_literal, "\n\n O número é maior que 10"]
[R_Paren, )]
[Semicolon, ;]
[ID 17, Scope 4, Subscope 0, s]
[Equal, =]
[String_literal, "errou"]
[Semicolon, ;]
[R_Brace, }]
[ID 19, Scope 4, Subscope 0, if]
[L_Paren, (]
[ID 15, Scope 4, Subscope 0, num]
[Relational_Op, ==]
[Digit, 10]
[R_Paren, )]
[L_Brace, {]
[ID 18, Scope 4, Subscope 0, printf]
[L_Paren, (]
[String_literal, "\n\n Você acertou!\n"]
[R_Paren, )]
[Semicolon, ;]
[ID 18, Scope 4, Subscope 0, printf]
[L_Paren, (]
[String_literal, "O numero é igual a 10."]
[R_Paren, )]
[Semicolon, ;]
[ID 17, Scope 4, Subscope 0, s]
[Equal, =]
[String_literal, "acertou"]
[Semicolon, ;]
[R_Brace, }]
[ID 19, Scope 4, Subscope 0, if]
[L_Paren, (]
[ID 15, Scope 4, Subscope 0, num]
[Relational_Op, <]
[Digit, 10]
[R_Paren, )]
[L_Brace, {]
[ID 18, Scope 4, Subscope 0, printf]
[L_Paren, (]
[String_literal, "\n\n O número é menor que 10"]
[R_Paren, )]
[Semicolon, ;]
[ID 17, Scope 4, Subscope 0, s]
[Equal, =]
[String_literal, "errou"]
[Semicolon, ;]
[R_Brace, }]
[ID 19, Scope 4, Subscope 0, if]
[L_Paren, (]
[ID 15, Scope 4, Subscope 0, num]
[Relational_Op, ==]
[Digit, 10]
[Logic_Op, &&]
[ID 17, Scope 4, Subscope 0, s]
[Relational_Op, ==]
[String_literal, "acertou"]
[R_Paren, )]
[L_Brace, {]
[ID 20, Scope 4, Subscope 0, return]
[Digit, 1]
[Semicolon, ;]
[R_Brace, }]
[ID 20, Scope 4, Subscope 0, return]
[Digit, 0]
[Semicolon, ;]
[R_Brace, }]
[ID 5, Scope 0, Subscope 0, void]
[ID 21, Scope 0, Subscope 0, AlterarVetor]
[L_Paren, (]
[ID 13, Scope 0, Subscope 0, int]
[Arith_Op: *]
[ID 22, Scope 5, Subscope 0, vetor]
[Comma, ,]
[ID 13, Scope 0, Subscope 0, int]
[ID 23, Scope 5, Subscope 0, elementos]
[R_Paren, )]
[L_Brace, {]
[ID 13, Scope 0, Subscope 0, int]
[ID 24, Scope 5, Subscope 0, i]
[Semicolon, ;]
[ID 25, Scope 5, Subscope 0, if]
[L_Paren, (]
[ID 22, Scope 5, Subscope 0, vetor]
[Relational_Op, !=]
[ID 26, Scope 5, Subscope 0, NULL]
[R_Paren, )]
[L_Brace, {]
[ID 27, Scope 5, Subscope 0, for]
[L_Paren, (]
[ID 24, Scope 5, Subscope 0, i]
[Equal, =]
[Digit, 0]
[Semicolon, ;]
[ID 24, Scope 5, Subscope 0, i]
[Relational_Op, <]
[ID 23, Scope 5, Subscope 0, elementos]
[Semicolon, ;]
[ID 24, Scope 5, Subscope 0, i]
[Inc_Op, ++]
[R_Paren, )]
[L_Brace, {]
[Pointer, *]
[L_Paren, (]
[ID 22, Scope 5, Subscope 0, vetor]
[R_Paren, )]
[Equal, =]
[Pointer, *]
[L_Paren, (]
[ID 22, Scope 5, Subscope 0, vetor]
[R_Paren, )]
[Arith_Op: *]
[Digit, 2]
[Semicolon, ;]
[ID 22, Scope 5, Subscope 0, vetor]
[Inc_Op, ++]
[Semicolon, ;]
[R_Brace, }]
[R_Brace, }]
[R_Brace, }]
[ID 13, Scope 0, Subscope 0, int]
[ID 0, Scope 0, Subscope 0, main]
[L_Paren, (]
[R_Paren, )]
[L_Brace, {]
[ID 13, Scope 0, Subscope 0, int]
[ID 28, Scope 6, Subscope 0, v]
[L_Bracket, []
[R_Bracket, ]]
[Equal, =]
[L_Brace, {]
[Digit, 5]
[Comma, ,]
[Digit, 10]
[Comma, ,]
[Digit, 15]
[Comma, ,]
[Digit, 3]
[Comma, ,]
[Digit, 10]
[Comma, ,]
[Digit, 76]
[Comma, ,]
[Digit, 5]
[Comma, ,]
[Digit, 13]
[Comma, ,]
[Digit, 33]
[Comma, ,]
[Digit, 45]
[R_Brace, }]
[Semicolon, ;]
[ID 13, Scope 0, Subscope 0, int]
[Arith_Op: *]
[ID 29, Scope 6, Subscope 0, pt]
[Semicolon, ;]
[ID 13, Scope 0, Subscope 0, int]
[ID 30, Scope 6, Subscope 0, i]
[Semicolon, ;]
[ID 29, Scope 6, Subscope 0, pt]
[Equal, =]
[ID 28, Scope 6, Subscope 0, v]
[Semicolon, ;]
[ID 21, Scope 0, Subscope 0, AlterarVetor]
[L_Paren, (]
[ID 28, Scope 6, Subscope 0, v]
[Comma, ,]
[Digit, 10]
[R_Paren, )]
[Semicolon, ;]
[ID 31, Scope 6, Subscope 0, for]
[L_Paren, (]
[ID 13, Scope 0, Subscope 0, int]
[ID 30, Scope 6, Subscope 0, i]
[Equal, =]
[Digit, 0]
[Semicolon, ;]
[ID 30, Scope 6, Subscope 0, i]
[Relational_Op, <]
[Digit, 10]
[Semicolon, ;]
[ID 30, Scope 6, Subscope 0, i]
[Inc_Op, ++]
[R_Paren, )]
[L_Brace, {]
[ID 32, Scope 6, Subscope 0, printf]
[L_Paren, (]
[String_literal, "V[%i] = %i\r\n"]
[Comma, ,]
[ID 30, Scope 6, Subscope 0, i]
[Comma, ,]
[Pointer, *]
[L_Paren, (]
[ID 29, Scope 6, Subscope 0, pt]
[Arith_Op: +]
[ID 30, Scope 6, Subscope 0, i]
[R_Paren, )]
[R_Paren, )]
[Semicolon, ;]
[R_Brace, }]
[ID 33, Scope 6, Subscope 0, CalculoMedia]
[L_Paren, (]
[R_Paren, )]
[Semicolon, ;]
[ID 34, Scope 6, Subscope 0, VerificaNumero]
[L_Paren, (]
[R_Paren, )]
[Semicolon, ;]
[ID 35, Scope 6, Subscope 0, return]
[Digit, 0]
[Semicolon, ;]
[R_Brace, }]
```
### Obs
You can change the txt file for your file locally 



