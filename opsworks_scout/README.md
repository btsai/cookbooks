# Custom Cookbook for Scout on AWS Opsworks

### Forked from git@github.com:scoutapp/scout_cookbooks.git 

Custom cookbook for OpsWorks

Main changes from the Scout original Chef recipe:
1. Tweaks for using in OpsWorks
2. Pull in API key and other settings from Opsworks Custom JSON

Install your custom cookbook repo on git (or elsewhere):
http://docs.aws.amazon.com/opsworks/latest/userguide/workingcookbook-installingcustom-enable.html

Make tweaks to settings in attributes/default.rb, as you see fit.

Make sure to include your Scout API as part of your deploy custom JSON, as follows:
```
{
  "deploy": {
    "SERVER_OR_APPLICATION_NAME": {
      "environment_variables": {
        "VAR_NAME": "VAR_VALUE",
        "SCOUT_API_KEY": "pDyfJxLjE6IoOe0WUzDFVGXCbFapI4mMwgralM7Q"
      },
      "rails_env": "production"
    }
  }
}
```

Add this to your RailsAppServer layer recipes, under Setup, as:
`opsworks_scout`


## Questions?

You can try to contact me through entering an issue, but I will need to pass this over to the Scout guys, since I'm a Rails guy and am fumbling around in the dark with dev ops stuff.


Contact Scout (<support@scoutapp.com>) with any questions, suggestions, bugs, etc.

## Authors and License

Minor OpsWorks tweaks:
Brian Tsai, May 2014

Additions, Modifications, & Updates:

Author: Derek Haynes (<support@scoutapp.com>)
Copyright: 2013, Scout
https://github.com/scoutapp/chef-scout

Author: Drew Blas (<drew.blas@gmail.com>)
Copyright: 2012, Drew Blas
https://github.com/drewblas/chef-scout_agent

Originally:

Author: Seth Chisamore (<schisamo@gmail.com>)
Copyright: 2010, Seth Chisamore
https://github.com/schisamo/chef_cookbooks

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
