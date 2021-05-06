# chia-monitoring

My messy set of "tools" to help me monitor and get some stats about Chia plotting/farming.

## Installation

Tested on GNU/Linux (Ubuntu 20.04).

1. Clone the repo and enter the directory
2. Optional: create a venv with `python -m venv venv` and activate `. ./venv/bin/activate`
3. `pip install -r requirements.txt`
4. `cp secrets.default.yaml secrets.yaml`
5. Configure your own Discord Webhook URL in `secrets.yaml`
6. Check out `scripts/`
   * `cron-farm.sh` will send you the output of `chia farm summary`
   * `cron-wallet.sh` same for `chia wallet show` (not sure why I even expect to get 1 $xch anyway...)
   * `cron-stats.sh` will output some stats that I found useful based on the plot logs. I'm currently using [swar/Swar-Chia-Plot-Manager](https://github.com/swar/Swar-Chia-Plot-Manager).
   * `cron-temp.sh` to check the temperature of my storage devices. You should be able to adapt for yours.

## FAQ

Q: What do you plan on adding to this repo? \
A: Not really sure yet but most likely random scripts like these that I find useful.

Q: Any plans on getting proper monitoring? \
A: Yes! I haven't played around with any monitoring solutions in many years. As time permits, I plan on investigating options and play around with things that work for me.

Q: How can I thank you for this? \
A: Hit the star and share with a friend if you find useful.

Q: Can I contribute with stuff? \
A: I don't see why not but note that I will only approve things that I find useful.

Q: Can I send you some $XCH? \
A: Sure, here's my wallet address: `xch1cxq3hyyfc06a88l4s47ncgsjjp5q7sgmndtyc7hmn5w438867pps66crkl`