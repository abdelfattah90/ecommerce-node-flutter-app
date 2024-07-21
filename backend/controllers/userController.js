import asyncHandler from 'express-async-handler'
import User from '../models/User.js'
import bcrypt from 'bcryptjs'

// @desc    Register a new user
// @route   POST /api/users/register
// @access  Public
const registerUser = asyncHandler(async (req, res) => {
  const { username, password, passwordConfirm } = req.body

  if (password !== passwordConfirm) {
    res.status(400)
    throw new Error('Passwords do not match')
  }

  const userExists = await User.findOne({ username })

  if (userExists) {
    res.status(400)
    throw new Error('User already exists')
  }

  const salt = await bcrypt.genSalt(10)
  const hashedPassword = await bcrypt.hash(password, salt)

  const user = await User.create({
    username,
    password: hashedPassword,
  })

  if (user) {
    res.status(201).json({
      _id: user._id,
      username: user.username,
    })
  } else {
    res.status(400)
    throw new Error('Invalid user data')
  }
})

// @desc    Auth user & get token
// @route   POST /api/users/login
// @access  Public
const authUser = asyncHandler(async (req, res) => {
  const { username, password } = req.body

  const user = await User.findOne({ username })

  if (user && (await bcrypt.compare(password, user.password))) {
    res.json({
      _id: user._id,
      username: user.username,
    })
  } else {
    res.status(401)
    throw new Error('Invalid username or password')
  }
})

// @desc    Auth user with Google
// @route   POST /api/users/google-login
// @access  Public
const googleLogin = asyncHandler(async (req, res) => {
  const { googleId } = req.body

  let user = await User.findOne({ googleId })

  if (!user) {
    user = await User.create({
      googleId,
      username: req.body.username,
    })
  }

  res.json({
    _id: user._id,
    username: user.username,
  })
})

export { registerUser, authUser, googleLogin }
