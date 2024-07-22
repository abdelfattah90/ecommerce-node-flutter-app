import User from '../models/User.js'

export const registerUser = async (req, res) => {
  const { username, email, password } = req.body

  try {
    const userExists = await User.findOne({ email })
    if (userExists) {
      return res.status(400).json({ message: 'Email already exists' })
    }

    const newUser = new User({
      username,
      email,
      password,
    })

    const savedUser = await newUser.save()
    res.status(201).json({
      _id: savedUser._id,
      username: savedUser.username,
      email: savedUser.email,
    })
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message })
  }
}
