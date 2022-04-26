step = 0
ind = 0
live_loop :timbre do
  use_synth :prophet
  riff = (ring :e3, :e3, :r, :g3, :r, :r, :r, :a3)
  possibleNotes = (ring riff.tick, riff.choose)
  if step % 8 == 0
    ind = rand_i(2)
  end
  print ind
  play possibleNotes[ind], attack: 0, release: 0.5, cutoff: 90
  sleep 2.0/8
  step=step+1
end

##| live_loop :amen_break do
##|   ##| use_bpm 50
##|   sample :loop_amen, beat_stretch: 2, cutoff: 120
##|   sleep 2.0
##| end

##| live_loop :timbre do
##|   use_synth (ring :tb303, :blade,
##|              :prophet, :saw, :beep, :tri).tick
##|   riff = (ring :e3, :e3, :r, :g3, :r, :r, :r, :a3)
##|   play riff.tick, attack: 0, release: 0.5, cutoff: 70
##|   sleep 0.5
##|   play riff.tick, attack: 0, release: 0.5, cutoff: 90
##|   sleep 0.5
##|   play riff.tick, attack: 0, release: 0.5, cutoff: 100
##|   sleep 0.5
##|   play riff.tick, attack: 0, release: 0.5
##|   sleep 0.5
##| end