# pssr package

This is the R package that accompanies the publication "A Step-By-Step Guide on Pre-registration and Effective Data Sharing for Psychopathology Research", authored by: Krypotos, A.-M., Klugkist, I., Mertens, G., and Engelhard, I. M.

## Installation

For using the software, you will first need to install [R](https://cran.r-project.org), [Rtools](https://cran.r-project.org/bin/windows/Rtools/), and [git](https://git-scm.com/]).

All this software is available for free and available on the following links: [R][https://cran.r-project.org](https://cran.r-project.org), [Rtools][https://cran.r-project.org/bin/windows/Rtools/](https://cran.r-project.org/bin/windows/Rtools/), and [git][https://git-scm.com/](https://git-scm.com/). 

After that, you can double click R and install the _pssr_ package by pasting the following code in the R console:

```r
# install.packages(devtools) # In case devtools is not installed, delete the first hashtag and run the command again.
library(devtools)
install_github("AngelosPsy/pssr")
```


## Usage

In any new R session, you can just load the package with the following command:

```r
library(pssr)
```

The package is now ready to be used. You can start now the program by just typing in:

```r
shiny_app()
```

The app window will now appear. After that, you will be able to navigate through the tabs and use the package as described in the publication.

# Help, buggs, requests

For help, buggs, or requests, you can use the issue tab in github: [https://github.com/AngelosPsy/pssr/issues](https://github.com/AngelosPsy/pssr/issues).








