import express from 'express'
import {
  registerUser,
  authUser,
  googleLogin,
} from '../controllers/userController.js'

const router = express.Router()

router.post('/register', registerUser)
router.post('/login', authUser)
router.post('/google-login', googleLogin)

export default router
