# load libraries and data files 
# uncomment below if necessary
# source('R/00_loadpackages.R')

# 01 load data --------------------------------------------------

### import data with `SWMPr::import_local()` and then clean it with `SWMPr::qaqc()` to screen observations
### check what the flags mean used in the `SWMPr::qaqc()` fxn here:  https://cdmo.baruch.sc.edu/data/qaqc.cfm.
### add in station name (for combining)
pi_1 <- SWMPr::import_local(path = here::here('data',
                                                 'swmp'), 
                               station_code = 'gtmpiwq') %>% 
        SWMPr::qaqc(qaqc_keep = c('0', '2', '3', '4', '5'))

pi <- subset(pi_1, subset = '2026-04-01 0:00', operator = '<')    
    
ss_1 <- SWMPr::import_local(path = here::here('data',
                                                 'swmp'), 
                               station_code = 'gtmsswq') %>% 
  SWMPr::qaqc(qaqc_keep = c('0', '2', '3', '4', '5')) 

ss <- subset(ss_1, subset = '2026-04-01 0:00', operator = '<')

fm_1 <- SWMPr::import_local(path = here::here('data',
                                                 'swmp'), 
                               station_code = 'gtmfmwq', trace = TRUE) %>% 
  SWMPr::qaqc(qaqc_keep = c('0', '2', '3', '4', '5'))

fm <- subset(fm_1, subset = '2026-04-01 0:00', operator = '<')

pc_1 <- SWMPr::import_local(path = here::here('data',
                                                 'swmp'), 
                               station_code = 'gtmpcwq') %>% 
  SWMPr::qaqc(qaqc_keep = c('0', '2', '3', '4', '5'))

pc <- subset(pc_1, subset = '2026-05-01 0:00', operator = '<')

MET_1 <- SWMPr::import_local(path = here::here('data',
                                             'swmp'), 
                                station_code = 'gtmpcmet', trace = TRUE) %>% 
  SWMPr::qaqc(qaqc_keep = c('0', '2', '3', '4', '5'))

MET <- subset(MET_1, subset = '2026-05-01 0:00', operator = '<')

# 02 wrangle data for merging ------------------------------------------------

# choose to add station name to the file for merging
pi2 <- pi %>% dplyr::mutate(station = 'gtmpiwq')
ss2 <- ss %>% dplyr::mutate(station = 'gtmsswq')
fm2 <- fm %>% dplyr::mutate(station = 'gtmfmwq')
pc2 <- pc %>% dplyr::mutate(station = 'gtmpcwq')

# plus MET
# MET <- MET %>% dplyr::mutate(station = 'gtmpcmet')

# combine all stations into one df (helpful to add station name)
WQ <- dplyr::bind_rows(pi2, ss2, fm2, pc2)

# choose to keep or remove individual stations
rm(pi2, ss2, fm2, pc2)


# 99 export as .RData -----------------------------------------------------

## uncomment below to export as .RData for use later.
save(WQ, file = here::here('output', 'data', 'WQ.RData'))
save(MET, file = here::here('output', 'data', 'MET.RData'))
save(pi, file = here::here('output', 'data', 'pi_wq.RData'))
save(ss, file = here::here('output', 'data', 'ss_wq.RData'))
save(fm, file = here::here('output', 'data', 'fm_wq.RData'))
save(pc, file = here::here('output', 'data', 'pc_wq.RData'))
