# """ Communicate directly with the Github v3.0 API"""

#Load the necessary packages
library(httr)
library(jsonlite)


ua <- user_agent("http://github.com/MarnixMichiel")
ua


githubAPI <- function(path) {
        url <- modify_url("https://api.github.com", path = path)
        
        resp <- GET(url, ua)
        if (http_type(resp) != "application/json") {
                stop("API did not return JSON", call. = FALSE)
        }
        
        parsed <- fromJSON(content(resp, "text"), simplifyVector = F)
        
        if (http_error(resp)) {
                stop(
                        sprintf(
                                "GitHub API request failed [%s]\n%s\n<%s>",
                                status_code(resp), 
                                parsed$message,
                                parsed$documentation_url
                        ),
                        call. = FALSE
                )
        }
        
        structure(
                list(
                        content = parsed,
                        path = path,
                        response = resp
                ),
                class = "githubAPI"
        )
}


print.githubAPI <- function(x, ...) {
        cat("<Github ", x$path, ">\n", sep = "")
        str(x$content)
        invisible(x)
}



