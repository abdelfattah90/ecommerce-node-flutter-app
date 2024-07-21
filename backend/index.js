import express from 'express'
import dotenv from 'dotenv'
import cors from 'cors'
import morgan from 'morgan'
import userRoutes from './routes/userRoutes.js'

import route from './routes/index.route.js'
import connectDB from './config/db.config.js'

const app = express()
dotenv.config()

// MIDDLEWARE
app.use(express.json())
app.use(cors())
app.use(morgan('dev'))

app.use('/api/users', userRoutes)

// ROUTES
app.use('/', route)

// DATABASE
connectDB()

app.listen(process.env.PORT || 8000, () => console.log('App Running...'))
