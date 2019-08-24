
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-100%25-lightgrey.svg)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/htmlunitjars.svg?branch=master)](https://travis-ci.org/hrbrmstr/htmlunitjars)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/htmlunitjars/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/htmlunitjars)
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.2.0-blue.svg)
![License](https://img.shields.io/badge/License-Apache-blue.svg)

# htmlunitjars

Java Archive Wrapper Supporting the ‘htmlunit’ Package

## Description

Contents of the ‘HtmlUnit’ & supporting Java archives
(<https://htmlunit.sourceforge.net/>). Version number reflects the
version number of the included ‘JAR’ file.

> *`HtmlUnit` is a “GUI-Less browser for Java programs”. It models HTML
> documents and provides an API that allows you to invoke pages, fill
> out forms, click links, etc… just like you do in your “normal”
> browser.*
> 
> *It has fairly good JavaScript support (which is constantly improving)
> and is able to work even with quite complex AJAX libraries, simulating
> Chrome, Firefox or Internet Explorer depending on the configuration
> used.*
> 
> *It is typically used for testing purposes or to retrieve information
> from web sites.*
> 
> *`HtmlUnit` is not a generic unit testing framework. It is
> specifically a way to simulate a browser.*

## What’s Inside The Tin

Everything necessary to use the HtmlUnit library directly via `rJava`.

`HtmlUnit` Library JavaDoc:
<https://htmlunit.sourceforge.net/apidocs/index.html>

## Installation

``` r
install.packages("htmlunitjars", repos = "https://cinc.rud.is")
# or
remotes::install_git("https://git.rud.is/hrbrmstr/htmlunitjars.git")
# or
remotes::install_git("https://git.sr.ht/~hrbrmstr/htmlunitjars")
# or
remotes::install_gitlab("hrbrmstr/htmlunitjars")
# or
remotes::install_bitbucket("hrbrmstr/htmlunitjars")
# or
remotes::install_github("hrbrmstr/htmlunitjars")
```

NOTE: To use the ‘remotes’ install options you will need to have the
[{remotes} package](https://github.com/r-lib/remotes) installed.

## Usage

``` r
library(htmlunitjars)

# current verison
packageVersion("htmlunitjars")
## [1] '2.36.0'
```

### Give It A Go

`xml2::read_html()` cannot execute javascript so the traditional
approach won’t work:

``` r
library(rvest)

test_url <- "https://hrbrmstr.github.io/htmlunitjars/index.html"

doc <- read_html(test_url)

html_table(doc)
## list()
```

☹️

We *can* do this with the classes from `HtmlUnit` proivided by this JAR
wrapper package:

``` r
library(htmlunitjars)
```

Tell `HtmlUnit` to work like FireFox:

``` r
browsers <- J("com.gargoylesoftware.htmlunit.BrowserVersion")

wc <- new(J("com.gargoylesoftware.htmlunit.WebClient"), browsers$CHROME)
```

Tell it to wait for javascript to execute and not throw exceptions on
page resource errors:

``` r
invisible(wc$waitForBackgroundJavaScriptStartingBefore(.jlong(2000L)))

wc_opts <- wc$getOptions()
wc_opts$setThrowExceptionOnFailingStatusCode(FALSE)
wc_opts$setThrowExceptionOnScriptError(FALSE)
```

Now, acccess the site again and get the table:

``` r
pg <- wc$getPage(test_url)

doc <- read_html(pg$asXml())

html_table(doc)
## [[1]]
##      X1   X2
## 1   One  Two
## 2 Three Four
## 3  Five  Six
```

No need for Selenium or Splash\!

The ultimate goal is to have an `htmlunit` package that provides a nicer
API than needing to know how to work with `rJava` directly.

## htmlunitjars Metrics

| Lang  | \# Files | (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :---- | -------: | --: | --: | ---: | ----------: | ---: | -------: | ---: |
| Java  |        2 | 0.2 |  28 | 0.30 |           5 | 0.11 |       18 | 0.17 |
| Rmd   |        1 | 0.1 |  21 | 0.22 |          35 | 0.76 |       50 | 0.48 |
| Maven |        1 | 0.1 |  17 | 0.18 |           0 | 0.00 |        1 | 0.01 |
| R     |        5 | 0.5 |  15 | 0.16 |           1 | 0.02 |       36 | 0.34 |
| make  |        1 | 0.1 |  13 | 0.14 |           5 | 0.11 |        0 | 0.00 |
