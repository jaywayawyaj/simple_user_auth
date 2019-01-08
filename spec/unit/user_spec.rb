require 'user'

describe User do
  let!(:user) { User.create(email: 'jethro@bea.com', password: 'bjjbbjjb')}
  let(:user_again) { User.create(email: 'jethro@bea.com',
                                        password: 'jbbjjbbj') }

  context '#self.authenticate' do
    it 'rejects non-existent user' do
      expect(User.authenticate('bea@jethro.com', 'rad')).to eq nil
    end

    it 'rejects incorrect password, user exists' do
      expect(User.authenticate('jethro@bea.com', 'lame')).to eq nil
    end
  end

  it 'accepts correct password, user exists' do
    expect(User.authenticate('jethro@bea.com', 'bjjbbjjb')).to eq user
  end

  describe '#valid?' do
    it 'ensures user email exists' do
      expect(user.valid?).to eq true
    end

    it "does not allow non-unique email address" do
      expect(user_again.valid?).to eq false
    end
  end
end
