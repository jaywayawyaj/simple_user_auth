require 'user'

describe User do
  let!(:user) { User.create(email: 'jethro@bea.com', password: 'bjjbbjjb')}

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
end
