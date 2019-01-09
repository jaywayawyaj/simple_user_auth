require 'user'

describe User do
  let!(:user) { User.create(email: 'jethro@bea.com', password: 'bjjbbjjb') }
  let!(:user2) { User.create(email: 'jethro@bea.com', password: 'jbbjjbbj') }

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

  context '#valid?' do
    it 'ensures user email exists' do
      expect(user.valid?).to eq true
    end

    it "does not allow non-unique email address" do
      expect(user2.valid?).to eq false
    end
  end

  context 'password' do
    it 'does not allow a short password to save' do
      expect(User.create(password: 'short')).to eq false
    end
    # it "validates password length" do
    #   expect(User.create(password: 'short')).should_not be_valid
    #   expect(User.create(password: 'secret123')).should be_valid
    # end
  end
end
