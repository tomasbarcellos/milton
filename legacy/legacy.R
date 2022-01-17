smooth = function(x){
  
  ks::kde(x, H, h, gridsize, gridtype, xmin, xmax, supp=3.7, eval.points,
          binned, bgridsize, positive=FALSE, adj.positive, w,
          compute.cont=TRUE, approx.cont=TRUE, unit.interval=FALSE,
          verbose=FALSE)
  
}

## Parse coordinates from mapsapi object
### String -> (Num,Num)
function(address){
  geo_points <- mapsapi::mp_geocode(adress, # Using Argolo`s key for now
                                    key = "AIzaSyB0bmdIoFucMt0Rv8Oy_FgerhysR1pNgxM") %>% 
    mp_get_points()}