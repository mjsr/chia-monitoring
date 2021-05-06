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
   * `cron-stats.sh` will output some stats that I found useful based on the plot logs. I'm currently using [swar/Swar-Chia-Plot-Manager](https://github.com/swar/Swar-Chia-Plot-Manager). The objective here is to help me understand if the config changes I made are helping or not. In this example, the time per plot increased (from ~5h50 to ~6h), when I reduced the stagger time aggressively (from 120min -> 60min -> 70min)

```
Phase 1 average time:
    For all plots: 02:06:15
    For last 5 plots: 02:16:57
    For last 4 plots: 02:19:08
    For last 3 plots: 02:21:44

Completion average time:
    For all plots: 05:53:27
    For last 5 plots: 06:12:31
    For last 4 plots: 06:09:58
    For last 3 plots: 06:04:31
```
   * `cron-temp.sh` to check the temperature of my storage devices. You should be able to adapt for yours. The objective here is to help me understand if there's enough cooling. A quick workaround is to open the window or turn on the AC. Relies on `smartmontools`' `smartctl` which needs to be run as root. Temperatures in Celsius, not sure if this can be changed. I'm find with Celsius :)

```
Storage temperature:
    nvme0n1: 32°C
    nvme1n1: 29°C
    nvme2n1: 29°C
    nvme3n1: 30°C
    nvme4n1: 29°C
    sda: 33°C
```

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