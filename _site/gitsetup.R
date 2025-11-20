library(usethis)

use_git_config(user.name = "TobiTuTuebingen", 
               user.email = "tobias.tuchel@objektfabrik.de")
usethis::git_default_branch_configure()

gitcreds::gitcreds_set()

