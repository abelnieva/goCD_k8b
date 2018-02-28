# gocd_test
test suite use ruby , chef / kitchen / google cloud

## initial setup
<pre>
* Ruby
* Chef SDK
</pre>

## installing bundler

<pre>
gem install bundler
</pre>

## installing dependencies  GEM

<pre>
bundle install
</pre>

## google cloud Auth

<pre>
1 . copy credentials.json file to gocd_test/files
2 . run setup_gcloud_key.sh script
</pre>

## kitchen create machine

<pre>
kitchen create
</pre>

## kitchen converge machine

<pre>
kitchen converge
</pre>

## kitchen list machines

<pre>
kitchen list
</pre>

<pre>
as soon as the machine is up and running, you can log over ssh , the test machine is up and running .
</pre>
