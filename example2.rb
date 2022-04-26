##| use_synth :tb303
four_notes = (ring :C, :G, :A, :F)

##| 4.times do
##|   play four_notes.tick
##|   sleep 0.5
##| end

##| 4.times do
##|   play four_notes.tick, release: 0.1
##|   sleep 0.5
##| end

##| use_random_seed 300
##| 4.times do
##|   play four_notes.choose
##|   sleep 0.5
##| end

##| use_random_seed 400
##| 4.times do
##|   play four_notes.choose
##|   sleep 0.5
##| end

##| 4.times do
##|   sample :ambi_piano
##|   sleep 0.5
##| end

##| 4.times do
##|   rates = [0.9, 2.1, 3.4, 4]
##|   sample :ambi_piano, rate: rates.tick
##|   sleep 0.5
##| end

##| 4.times do
##|   pans = [-1, 1, 0, 0]
##|   play four_notes[0], pan:pans.tick
##|   sleep 0.5
##| end

##| use_random_seed 2
##| 4.times do
##|   play rrand_i(60,72)
##|   sleep 0.5
##| end

##| 10.times do
##|   sample :perc_bell, rate:rrand(0.125,1.8)
##|   sleep rrand(0.1,1.2)
##| end

##| play hz_to_midi(200)

effects = [:bitcrusher, :slicer, :echo, :whammy,:tremolo, :ping_pong, :krush, :distortion]
effects.length.times do
  with_fx effects.tick do
    4.times do
      play four_notes.tick
      sleep 0.50
    end
  end
end