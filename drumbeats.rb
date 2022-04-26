# from https://i.pinimg.com/564x/a1/3b/fc/a13bfc8659badc31dd5a54bcfda2dad5.jpg
# and https://i.pinimg.com/564x/cf/18/33/cf18331e8994602edb1a662c131f5cc8.jpg
uk_garage = ["k","r","c","c",
             "l","t","c","r",
             "","","ck","t",
             "l","r","c","c",
             "k","","c","",
             "l","t","c","r",
             "","","ck","t",
             "l","r","c",""]

dubstep = ["k","c","c","",
           "o","","c","",
           "s","","k","c",
           "","o","c","",
           "k","c","c","k",
           "o","","ck","",
           "s","","k","c",
           "","o","c",""]

footwork = ["rk","r","rc","rk",
            "r","r","rk","r",
            "rk","r","rc","rk",
            "rl","r","rk","r",
            "rl","r","rc","rk",
            "r","r","rkc","rc",
            "rk","r","rc","rk",
            "rl","r","rkc","r"]

trap = ["ck","","c","",
        "c","","ck","",
        "cs","","c","",
        "ck","","c","",
        "c","","ck","",
        "ck","","c","",
        "cs","","c","",
        "c","","c",""]

drum_n_bass = ["koc","","c","",
               "cs","","ck","",
               "c","","cs","",
               "cs","","c","",
               "kc","","c","",
               "cs","","c","",
               "c","","ck","",
               "cs","","c",""]

jungle = ["ock","","ck","",
          "cs","","c","s",
          "c","s","ck","",
          "c","","cs","",
          "c","sk","ck","",
          "cs","","c","s",
          "c","s","ck","",
          "c","","cs",""]

deep_house = ["k","c","o","",
              "lk","","o","c",
              "k","c","o","",
              "lk","","o",""]

hip_hop = ["ck","","ck","",
           "cs","","c","",
           "c","","ck","k",
           "cs","","c","k"]

when_levee_breaks = ["ck","k","c","",
                     "cs","","c","k",
                     "c","","ck","k",
                     "cs","","c",""]


funky = ["ck","c","ck","c",
         "cs","c","kc","so",
         "c","sc","ck","sc",
         "cs","ko","c","sc"]

patterns = [uk_garage,dubstep,footwork,trap,drum_n_bass,jungle,deep_house,hip_hop,when_levee_breaks,funky]

live_loop :drum do
  currPattern = funky.tick #change the id of patterns
  sample :drum_heavy_kick if currPattern.include?("k")
  sample :drum_snare_hard if currPattern.include?("s")
  sample :drum_cymbal_closed if currPattern.include?("c")
  sample :drum_cymbal_open if currPattern.include?("o")
  sample :drum_tom_lo_hard if currPattern.include?("t")
  #sample * if currPattern.include?("l")
  #sample * if currPattern.include?("r")
  sleep 0.25
end