# SQL projekt

## Úvod
Tento projekt se zaměřuje na posouzení **dostupnosti základních potravin pro širokou veřejnost** prostřednictvím analýzy příslušných datových sad. Cílem je odpovědět na definované **výzkumné otázky**, které se týkají porovnání dostupnosti potravin na základě **průměrných příjmů** za specifická **časová období**.

-   **Průměrná mzda v odvětvích:** Data pro období **2000-2021**.
-   **Ceny kategorií potravin:** Data pro období **2006-2018**.

Jako dodatečný materiál jsem také připravil tabulku s údaji o **HDP, GINI koeficientu** a **populaci dalších evropských států** ve stejném období jako primární data pro Českou republiku.

### Výzkumné otázky

1.  Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2.  Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3.  Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4.  Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5.  Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

# 1.
Obecně lze říci, že mzdy v průběhu let rostou ve všech odvětvích.

V těchto odvětvích mzdy vždy rostli, nebo zůstali na stejné hodnotě:
- zpracovatelský průmysl
- doprava a skladování
- zdravotní a sociální péče
- ostatní činnosti

![alt text](image-6.png)

V některých odvětvích docházelo k poklesům mezd s postupným zotavením v následujích letech. Nejvíce v roce 2013, kdy k nejvetším poklesům mezd došlo v těchto odvětvích:
- těžba a dobývání
- výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu
- peněžnictví a pojišťovnictví
- profesní, vědecké a technické činnosti

![alt text](image-5.png)