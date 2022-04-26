

live_loop :spiriti do
  sample :ambi_choir, rate: rand()
  sleep rand(2..4)
end

live_loop :piano do
  sample :ambi_piano, rate: rand()
  sleep 0.5
end
