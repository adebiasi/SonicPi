live_loop :metro do
  use_synth :beep
  play :c5, amp:0.5 # as boring as a real metronome
  sleep 1
  
end

## 1 bar = 4 beats
live_loop :bar do
  sleep 4
end


live_loop :bdrum do
  sync :metro
  sample :bd_ada
end

live_loop :snare do
  sync :bar
  sleep 2
  sample :drum_snare_hard
  sleep 0.5
  sample :drum_snare_hard
  sleep 0.5
  sample :drum_cymbal_open, pan: -1, amp: 0.5
  # sleep 1 #
  
end

live_loop :hits_hats do
  sync :metro
  with_fx :bpf do
    sample :drum_cymbal_soft
    sleep 0.5
    sample :drum_cymbal_soft
    sleep 0.499 # less than 0.5 !
  end
  
end



## as the loop takes 4 beats to play
## the musician behind the propher is not free to receive from the chief "the same man"
## so this live_loop will be played only every 2 bars
live_loop :player_prophet do
  ##| stop
  sync :bar
  use_synth :prophet
  with_fx :reverb do
    play_pattern_timed [:c2, :C3], 2, sustain: 0.5
    # this is surprenant but this is how it works.
  end
end

## as the loop takes less than 4 beats to play
## the musician behind the piano is free to receive from the chief "the same man !" and play
live_loop :player_piano do
  ##| stop
  sync :bar
  use_synth :piano
  play_pattern_timed [:c3, :c2, :b6, :b5+0.15,
                      72, 72.25,72.5, :c2-0.15], 0.25, sustain: 0.1
  
end