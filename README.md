# SonicPi

This repo contains some code to practice with SonicPi.

# Guitar BackingTrack Generator

# Drum Beats

Drum beats samples taken from the following references:
<br><br>
<img src="https://github.com/adebiasi/SonicPi/blob/main/DrumBeats/References/Beats.jpg" alt="drawing" height="400"/>
<img src="https://github.com/adebiasi/SonicPi/blob/main/DrumBeats/References/ClassicBreakBeats.jpg" alt="drawing" height="400"/>

# Basic exercises

## Notes and chords

### Play a note
```ruby
play 60
```

### Play 4 random notes
```ruby
4.times do
  play rrand_i(60, 90)
  sleep 0.5
end
```

### Play a major chord
```ruby
play chord(60, :M)
```

### Play a minor chord
```ruby
play chord(60, :m)
```

### Play an sequential arpeggio
```ruby
loop do
  play chord(60, :M7).tick
  sleep 0.5
end
```

### Play a chord with a random arpeggio
```ruby
loop do
  play chord(60, :M7), release: 3
  16.times do # 16*0.25 = 4 beats
    play chord(60, :M7).choose
    sleep 0.25
  end
end
```

### Play a shifting chord with a random arpeggio
```ruby
start_notes = ring(60, 62, 63, 62)
loop do
  my_chord = chord(start_notes.tick, :M7)
  play my_chord, release: 2
  16.times do # 16*0.125 = 2 beats
    play my_chord.choose, release: 0.25
    sleep 0.125
  end
end
```

### Play a shifting minor/major chord with a random arpeggio
```ruby
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
```

### Play a shifting minor/major chord with a random arpeggio (with parameters)
```ruby
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
```

### Play a shifting minor/major chord with a sequential arpeggio (using play_pattern_timed)
```ruby
notes = ring(:c5, :g4, :a4, :f4)
chord_type = ring(:M, :M, :m, :M)
loop do
  my_chord = chord(notes.tick, chord_type.look)
  duration = 4.0
  num_rep = 4
  play my_chord, release: duration
  num_rep.times do
    play_pattern_timed(my_chord.reflect,duration/(my_chord.length*num_rep))
  end
end
```

### Play a shifting minor/major chord with a guitar style arpeggio (using play_pattern_timed)
```ruby
notes = ring(:c5, :g4, :a4, :f4)
chord_type = ring(:M, :M, :m, :M)

loop do
  my_chord = chord(notes.tick, chord_type.look)
  duration = 4.0
  play my_chord, release: duration
  pattern = chord(notes.look, chord_type.look, num_octaves: 2).take(4).reflect.butlast.repeat(4)
  play_pattern_timed(pattern,duration/pattern.length)
end
```

### Play a shifting minor/major chord with a guitar style arpeggio (using play_pattern_timed and chord_degree)
```ruby
loop do
  duration = 4.0
  my_chord = chord_degree([8,5,6,4].tick, :c4, :major, 3)
  play my_chord, release: duration
  pattern = (my_chord+my_chord.map{|n| n+12}).take(4).reflect.butlast.repeat(4)
  play_pattern_timed(pattern,duration/pattern.length)
end
```

## Play options

### Change amp, same for sample
```ruby
play 60, amp: 1
sleep 1
play 60, amp: 4
sleep 1
play 60, amp: 6
sleep 1
```

### Change pan, same for sample
```ruby
play 60, pan: 0
sleep 1
play 60, pan: -1
sleep 1
play 60, pan:1
sleep 1
```

### Change attack, sustain, release
```ruby
in_thread do
  play 60, attack: 2,sustain: 2,release: 0
  sleep 6
  play 60, attack: 2, sustain: 2,release: 2
  sleep 6
  play 60, attack: 0,sustain: 2,release: 2
  sleep 6
end

loop do
  sample :drum_bass_soft
  sleep 2
end
```

## Samples

### Play a sample
```ruby
sample :drum_bass_hard
```

### Play a simple drum beat
```ruby
loop do
  sample :bd_haus
  sleep 0.5
end
```

### Alternate kick and snare
```ruby
loop do
  if tick.even?
    sample :bd_haus
  else
    sample :sn_dolf
  end
  sleep 0.5
end
```

### Combine kick, snare and hi-hat
```ruby
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
```

### Play a drum loop once
```ruby
sample :loop_amen
```

### Play a drum loop as a loop
```ruby
loop do
  sample :loop_amen
  sleep sample_duration(:loop_amen)
end
```

### Try to combine melody, harmony, rhythm (doesn't work)
```ruby
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
```

### A fix for Example 13, using threads (drums out of sync)
```ruby
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
```

### A fix for Example 14, drums now in sync
```ruby
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
```

### A better way to thread
```ruby
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
```

### Use a different synth
```ruby
use_synth :saw
loop do
  play scale(60, :major).choose
  sleep 0.25
end
```

### A simple pattern to demo effects
```ruby
play 50
sleep 0.5
sample :elec_plip
sleep 0.5
play 62
```

### Adding reverb
```ruby
with_fx :reverb do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end
```

### Adding echo
```ruby
with_fx :echo do
  play 50
  sleep 0.5
  sample :elec_plip
  sleep 0.5
  play 62
end
```

### Adding reverb and echo together
```ruby
with_fx :echo do
  with_fx :reverb do
    play 50
    sleep 0.5
    sample :elec_plip
    sleep 0.5
    play 62
  end
end
```
