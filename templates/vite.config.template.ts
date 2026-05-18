/**
 * TEMPLATE — copy and adjust. Vite 8 + React Compiler 1.0 GA.
 * See https://vite.dev/config/ and https://react.dev/learn/react-compiler.
 */
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [
    react({
      babel: {
        plugins: [['babel-plugin-react-compiler', { target: '19' }]]
      }
    })
  ],
  server: { port: 5173, strictPort: true },
  build: { target: 'es2024', sourcemap: true }
});

