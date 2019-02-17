# pssr package

This is the R package that accompanies the publication "A Step-By-Step Guide on Pre-registration and Effective Data Sharing for Psychopathology Research", authored by: Krypotos, A.-M., Klugkist, I., Mertens, G., and Engelhard, I. M.

## Installation

For using the software, you will first need to install [R](https://cran.r-project.org), [Rtools](https://cran.r-project.org/bin/windows/Rtools/), and [git](https://git-scm.com/]).

All this software is available for free and available on the following links: [R][https://cran.r-project.org](https://cran.r-project.org), [Rtools][https://cran.r-project.org/bin/windows/Rtools/](https://cran.r-project.org/bin/windows/Rtools/), and [git][https://git-scm.com/](https://git-scm.com/). 

After that, you can double click R and install the _pssr_ package by pasting the following code in the R console:

```r
if(!require(devtools)) { install.packages("devtools") } # Install devtools in case it is not installed
devtools::install_github("AngelosPsy/pssr")
```

## Tutorial
A tutorial of how to use the package can be found in [pdf](tutorial_pssr.pdf) or [html](http://htmlpreview.github.io/?) format.  

If you do not want to read the tutorial but want to just play with the program, first install the software , start an R session
and type in 

```r
pssr::shiny_app()
```

The app window will now appear. After that, you will be able to navigate through the tabs and use the package as described in the publication (or the tutorial...).

# Help, bugs, requests

For help, bugs, or requests, you can use the issue tab in github: [https://github.com/AngelosPsy/pssr/issues](https://github.com/AngelosPsy/pssr/issues).

# Citation

Our package is described in:

Krypotos, A., Kluglist, I. G., Mertens, G., & Engelhard, I. (in press). A Step-By-Step Guide on Preregistration and Effective Data Sharing for Psychopathology Research. _Journal of Abnormal Psychology_.

A preprint of the article can be found here: https://doi.org/10.31234/osf.io/ysgfa
