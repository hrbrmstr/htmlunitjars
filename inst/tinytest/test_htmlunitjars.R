library(htmlunitjars)

browsers <- J("com.gargoylesoftware.htmlunit.BrowserVersion")

expect_equal(browsers$class$toString(), "class com.gargoylesoftware.htmlunit.BrowserVersion")

wc <- new(J("com.gargoylesoftware.htmlunit.WebClient"), browsers$CHROME)

expect_true(wc$isJavaScriptEnabled())

invisible(wc$waitForBackgroundJavaScriptStartingBefore(.jlong(2000L)))

wc_opts <- wc$getOptions()

prox <- wc_opts$getProxyConfig()

expect_equal(prox$getProxyPort(), 0)

wc_opts$setThrowExceptionOnFailingStatusCode(FALSE)
wc_opts$setThrowExceptionOnScriptError(FALSE)

test_url <- "https://httpbin.org/"

pg <- wc$getPage(test_url)

expect_equal(pg$getTitleText(), "httpbin.org")

