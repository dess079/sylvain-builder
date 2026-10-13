/**
 * TEMPLATE — copy and adjust. Vite 8 + React Compiler 1.0 GA.
 * See https://vite.dev/config/ and https://react.dev/learn/react-compiler.
 */
import { defineConfig } from 'vite';
import babel from '@rolldown/plugin-babel';
import react, { reactCompilerPreset } from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [
    react(),
    babel({ presets: [reactCompilerPreset()] })
  ],
  server: { port: 5173, strictPort: true },
  build: { target: 'es2024', sourcemap: true }
});

