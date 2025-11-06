# UTFPR TCC (unofficial)

* [English](#quick-start)
* [Portuguese](#início-rápido)

---

<h2 align="center">English</h2>

<center>
  UTFPR TCC template made by students for students
</center>

## Quick start

All the arguments below have default values, hence, optionals.

```typst
#import "@local/utfpr-tcc-unofficial:0.1.0": * 

#show: template.with(  
  title: [the title],
  title-foreign: [the title in the foreign language],

  lang: "pt",
  lang-foreign: "en",
  
  author: [your full name],
  city: [city],
  year: [year],

  description: [That little block on the second page.],

  keywords: ([word 1], [word 2], [word 3], [word 4]),
  keywords-foreign: ([palavra 1], [palavra 2], [palavra 3], [palavra 4]),
  
  abstract: [abstract],
  abstract-foreign: [your abstract in the foreign language],

  outline-figure: true,
  outline-table: true,
  abbreviations: (
    [ABNT], [Associação Brasileira de Normas Técnicas],
    [Coef.], [Coeficiente], 
    [IBGE], [Instituto Brasileiro de Geografia e Estatística],
    [NBR], [Normas Brasileiras], 
    [UTFPR], [Universidade Tecnológica Federal do Paraná],
  ),
)
```

## Description 

A Template for UTFPR TCC (Trabalho de Conclusão de Curso) 
made by students for students to facilitate TCC production in typst. 
Be aware that this is an unofficial template, prone to errors. 
It's an open source project designed for anyone that wants to contribute
be able to, especially if the standard gets updated, 
some feature is incorrect or missing.

---

<h2 align="center">Portuguese</h2>

<center>
  Modelo UTFPR TCC criado por estudantes para estudantes
</center>

## Início rápido

Todos os argumentos abaixo possuem valores padrão, portanto, opcionais.

```typst
#import "@local/utfpr-tcc-unofficial:0.1.0": * 

#show: template.with(  
  title: [título],
  title-foreign: [título na linguagem estrangeira],

  lang: "pt",
  lang-foreign: "en",
  
  author: [seu nome completo],
  city: [cidade],
  year: [ano],

  description: [Aquele pequeno bloco na contra-capa.],

  keywords: ([palavra 1], [palavra 2], [palavra 3], [palavra 4]),
  keywords-foreign: ([word 1], [word 2], [word 3], [word 4]),
  
  abstract: [resumo],
  abstract-foreign: [seu resumo na linguagem estrangeira],

  outline-figure: true,
  outline-table: true,
  abbreviations: (
    [ABNT], [Associação Brasileira de Normas Técnicas],
    [Coef.], [Coeficiente], 
    [IBGE], [Instituto Brasileiro de Geografia e Estatística],
    [NBR], [Normas Brasileiras], 
    [UTFPR], [Universidade Tecnológica Federal do Paraná],
  ),
)
```

## Descrição

Um modelo para TCC (Trabalho de Conclusão de Curso) UTFPR
criado por estudantes para estudantes, com o objetivo de facilitar a produção de TCCs no Typst.
Este é um modelo não oficial, sujeito a erros.
Trata-se de um projeto de código aberto, criado para que qualquer pessoa que 
deseje contribuir possa fazê-lo, especialmente se o padrão for atualizado,
alguma funcionalidade estiver incorreta ou ausente.
