##| with_fx :reverb, room: 1 do
##|   live_loop :time do
##|     synth :prophet, release: 8, note: :e1, cutoff: 90, amp: 3
##|     sleep 8
##|   end
##| end
##| live_loop :machine do
##|   ##| sample :loop_garzul, rate: 0.5, fnish: 0.25
##|   sample :loop_industrial, beat_stretch: 1, amp: 1
##|   sleep 4
##| ##| end
##| live_loop :kik do
##|   sample :bd_haus, amp: 2
##|   sleep 0.5
##| end
##| with_fx :echo do
notes = (scale :a5, :minor_pentatonic, num_octaves: 1)
count = 0
randNumb = rand(250)
live_loop :vortex do
  count+=1
  randNumb = rand(250) if count % 4 == 0
  print( randNumb)
  use_random_seed randNumb
  
  4.times do
    play notes.choose, release: 0.1, amp: 1.5
    sleep 1.0
  end
end
##| end

