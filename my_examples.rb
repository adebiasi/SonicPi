##############################################
## Notes and chords
##############################################

##############################################
## play a note
play 60


##############################################
## play 4 random notes
4.times do
  play rrand_i(60, 90)
  sleep 0.5
end


##############################################
## play a major chord
play chord(60, :M)


##############################################
## play a minor chord
play chord(60, :m)


##############################################
## play an sequential arpeggio
loop do
  play chord(60, :M7).tick
  sleep 0.5
end


##############################################
## play a chord with a random arpeggio
loop do
  play chord(60, :M7), release: 3
  16.times do # 16*0.25 = 4 beats
    play chord(60, :M7).choose
    sleep 0.25
  end
end


##############################################
## play a shifting chord with a random arpeggio
start_notes = ring(60, 62, 63, 62)
loop do
  my_chord = chord(start_notes.tick, :M7)
  play my_chord, release: 2
  16.times do # 16*0.125 = 2 beats
    play my_chord.choose, release: 0.25
    sleep 0.125
  end
end

##############################################
## play a shifting minor/major chord with a random arpeggio
notes = ring(:c5, :g4, :a4, :f4)
chord_type = ring(:M, :M, :m, :M)
loop do
  my_chord = chord(notes.tick, chord_type.look)
  play my_chord, release: 2
  16.times do # 16*0.125 = 2 beats
    play my_chord.choose, release: 0.2
    sleep 0.125
  end
end

##############################################
## play a shifting minor/major chord with a random arpeggio (with parameters)
notes = ring(:c5, :g4, :a4, :f4)
chord_type = ring(:M, :M, :m, :M)
loop do
  my_chord = chord(notes.tick, chord_type.look)
  duration = 4.0
  play my_chord, release: duration
  num_arp_notes = 16
  num_arp_notes.times do
    play my_chord.choose, release: 0.2
    sleep duration/num_arp_notes
  end
end


##############################################
## play a shifting minor/major chord with a sequential arpeggio (using play_pattern_timed)
notes = ring(:c5, :g4, :a4, :f4)
chord_type = ring(:M, :M, :m, :M)
loop do
  my_chord = chord(notes.tick, chord_type.look)
  duration = 4.0
  num_rep = 4
  play my_chord, release: duration
  num_rep.times do
    play_pattern_timed(my_chord,duration/(my_chord.length*num_rep))
  end
end

##############################################
## play a shifting minor/major chord with a guitar style arpeggio (using play_pattern_timed)
notes = ring(:c5, :g4, :a4, :f4)
chord_type = ring(:M, :M, :m, :M)

loop do
  my_chord = chord(notes.tick, chord_type.look)
  duration = 4.0
  play my_chord, release: duration
  pattern = chord(notes.look, chord_type.look, num_octaves: 2).take(4).reflect.butlast.repeat(4)
  play_pattern_timed(pattern,duration/pattern.length)
end


##############################################
## play a shifting minor/major chord with a guitar style arpeggio (using play_pattern_timed and chord_degree)
loop do
  duration = 4.0
  my_chord = chord_degree([8,5,6,4].tick, :c4, :major, 3)
  play my_chord, release: duration
  pattern = (my_chord+my_chord.map{|n| n+12}).take(4).reflect.butlast.repeat(4)
  play_pattern_timed(pattern,duration/pattern.length)
end


##############################################
## Samples
##############################################


##############################################
## Example 7 - play a sample
sample :drum_bass_hard


##############################################
## Example 8 - play a simple drum beat
loop do
  sample :bd_haus
  sleep 0.5
end


##############################################
## Example 9 - alternate kick and snare
loop do
  if tick.even?
    sample :bd_haus
  else
    sample :sn_dolf
  end
  sleep 0.5
end


##############################################
## Example 10 - combine kick, snare and hi-hat
loop do
  sample :drum_cymbal_closed
  if tick.even?
    sample :bd_haus
  else
    sample :sn_dolf
  end
  sleep 0.25
  sample :drum_cymbal_closed
  sleep 0.25
end


##############################################
## Example 11 - play a drum loop once
sample :loop_amen


##############################################
## Example 12 - play a drum loop as a loop
loop do
  sample :loop_amen
  sleep sample_duration(:loop_amen)
end


##############################################
## Example 13 - try to combine melody, harmony, rhythm (doesn't work)
loop do
  start_note = ring(60, 62, 63, 62).tick
  my_chord = chord(start_note, :M7)
  play my_chord, release: 2
  16.times do
    play my_chord.choose, release: 0.25, amp: [0.75, 0.5, 0.25].choose
    sleep 0.125
  end
end

loop do
  sample :loop_amen
  sleep sample_duration(:loop_amen)
end


##############################################
## Example 14 - a fix for Example 13, using threads (drums out of sync)
in_thread do
  loop do
    start_note = ring(60, 62, 63, 62).tick
    my_chord = chord(start_note, :M7)
    play my_chord, release: 2
    16.times do
      play my_chord.choose, release: 0.25, amp: [0.75, 0.5, 0.25].choose
      sleep 0.125
    end
  end
end

loop do
  sample :loop_amen
  sleep sample_duration(:loop_amen)
end


##############################################
## Example 15 - a fix for Example 14, drums now in sync
in_thread do
  loop do
    start_note = ring(60, 62, 63, 62).tick
    my_chord = chord(start_note, :M7)
    play my_chord, release: 2
    16.times do
      play my_chord.choose, release: 0.25, amp: [0.75, 0.5, 0.25].choose
      sleep 0.125
    end
  end
end

loop do
  sample :loop_amen, beat_stretch: 2
  sleep 2
end


##############################################
## Example 16 - a better way to thread
live_loop :beeps do
  start_note = ring(60, 62, 63, 62).tick
  my_chord = chord(start_note, :M7)
  play my_chord, release: 2
  16.times do
    play my_chord.choose, release: 0.25, amp: [0.75, 0.5, 0.25].choose
    sleep 0.125
  end
end

live_loop :drums do
  sample :loop_amen, beat_stretch: 2
  sleep 2
end


##############################################
## Example 17 - use a different synth
use_synth :saw
loop do
  play scale(60, :major).choose
  sleep 0.25
end


##############################################
## Example 18 - a simple pattern to demo effects
play 50
sleep 0.5
sample :elec_plip
sleep 0.5
play 62


##############################################
## Example 19 - adding reverb
with_fx :reverb do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end


##############################################
## Example 20 - adding echo
with_fx :echo do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end


##############################################
## Example 21 - adding reverb and echo together
with_fx :echo do
  with_fx :reverb do
    play 50
    sleep 0.5
    sample :elec_plip
    sleep 0.5
    play 62
  end
end