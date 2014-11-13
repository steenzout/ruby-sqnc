# steenzout-sqnc

[![Code Climate](https://codeclimate.com/github/steenzout/steenzout-sqnc.png)](https://codeclimate.com/github/steenzout/steenzout-sqnc)
[![Gem Version](https://badge.fury.io/rb/steenzout-sqnc.svg)](http://badge.fury.io/rb/steenzout-sqnc)
[![steenzout-sqnc API Documentation](https://www.omniref.com/ruby/gems/steenzout-sqnc.png)](https://www.omniref.com/ruby/gems/steenzout-sqnc)


This gem provides simple sequence management functionality.



## Configuration

You can only use one type of sequence manager implementation.


### implement sequence on a file

<pre><code>:steenzout-sqnc:
  :implementation: :file
  :sequences:
    :seq1:
      :location: '/opt/local/steenzout/sequence1'
    :seq2:
      :location: '/opt/local/steenzout/sequence2'
      :step: 100
      :offset: 100
</code></pre>


### implement sequence on a TokyoCabinet database

<pre><code>:steenzout-sqnc:
  :implementation: :tokyocabinet
  :sequences:
    :seq1:
      :location: '/opt/local/steenzout/sequence1.tch'
    :seq2:
      :location: '/opt/local/steenzout/sequence2.tch'
      :step: 100
      :offset: 100
</code></pre>
