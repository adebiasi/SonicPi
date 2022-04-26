use_bpm 60

##| live_loop :random_riff do
##|   use_synth :dsaw
##|   use_random_seed 2
##|   notes = (scale :e3, :minor_pentatonic).shuffle
##|   play notes.tick, release: 0.25, cutoff: 70
##|   sleep 2.0/notes.length
##| end

live_loop :random_riff do
  use_synth :dsaw
  use_random_seed 2
  notes = (scale :e3, :minor_pentatonic).shuffle
  16.times do
    play notes.tick, release: 0.2, cutoff: 90 if one_in(3)
    sleep 0.125
  end
end

live_loop :amen_break do
  ##| use_bpm 50
  sample :loop_amen, beat_stretch: 2.0, cutoff: 120
  sleep 2.0
end