require 'spec_helper'

describe SunFrog::Models::Item do
  subject { described_class.new(size: 'L', quantity: 5, m: '44091') }
  describe 'initialization' do
    it { expect(subject.size).to be     == 'L'     }
    it { expect(subject.quantity).to be == 5       }
    it { expect(subject.m).to be        == '44091' }
  end
end
