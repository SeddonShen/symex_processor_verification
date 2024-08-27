
```bash
# { time btormc -ca -kmin 4 -kmax 20 --trace-gen-full -v 1 "$btor_file"; } &> "$log_file"
{ make clean && time make; } &> E5.log
```