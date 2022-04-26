
##| live_loop :main_structure do
##|   sleep 1
##| end



live_loop :first  do
  ##| sync :main_structure
  riff = (ring :e3, :r)
  play riff.tick
  sleep 0.5
end


##| live_loop :second do
##|   ##| sync :main_structure
##|   riff = (ring :r,:a3)
##|   play riff.tick
##|   sleep 0.5
##| end