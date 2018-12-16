
# htmlunitjars

Java Archive Wrapper Supporting the ‘htmlunit’ Package

## Description

Contents of the `HtmlUnit` & supporting Java archives
<http://htmlunit.sourceforge.net/>. Version number reflects the version
number of the included ‘JAR’ file.

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
<http://htmlunit.sourceforge.net/apidocs/index.html>

## Installation

``` r
devtools::install_github("hrbrmstr/htmlunitjars")
```

## Usage

``` r
library(htmlunitjars)

# current verison
packageVersion("htmlunitjars")
```

    ## [1] '2.33.0'

### Give It A Go

`xml2::read_html()` cannot execute javascript so the traditional
approach won’t work:

``` r
library(rvest)

test_url <- "https://hrbrmstr.github.io/htmlunitjars/index.html"

doc <- read_html(test_url)

html_table(doc)
```

    ## list()

☹️

We *can* do this with the classes from `HtmlUnit` proivided by this JAR
wrapper package:

``` r
library(htmlunitjars)
```

Tell `HtmlUnit` to work like FireFox:

``` r
browsers <- J("com.gargoylesoftware.htmlunit.BrowserVersion")

wc <- new(J("com.gargoylesoftware.htmlunit.WebClient"), browsers$FIREFOX_17)
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
```

    ## [[1]]
    ##      X1   X2
    ## 1   One  Two
    ## 2 Three Four
    ## 3  Five  Six

No need for Selenium or Splash\!

The ultimate goal is to have an `htmlunit` package that provides a nicer
API than needing to know how to work with `rJava` directly.
