; Drush Make API version. 
api = 2 
; Drupal core. 
core = 7.36

;Common modules. 
projects[admin_menu][subdir] = "contrib" 
projects[ctools][subdir] = "contrib" 
projects[token][subdir] = "contrib" 
projects[views][subdir] = "contrib"

; Development modules. 
projects[devel][subdir] = "development" 

; Multilingual modules. 
projects[fallback_language_negotation][subdir] = "contrib" 
projects[variable][subdir] = "contrib" 
projects[i18n][subdir] = "contrib" 
projects[i18nviews][subdir] = "contrib" 

; Load some translations. 
translations[] = en 
translations[] = ru
