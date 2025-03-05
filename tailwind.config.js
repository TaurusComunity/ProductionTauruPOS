/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./*.html"],
    theme: {
      extend: {
          
          colors: {
              mono: {
                blanco: '#F5EFFF',
                negro: '#060809',
              },
              bg: {
                empty: '#1F1D2B',
              },
              semaforo: {
                verde: '#1BCC75',
                verde_opacity: '#1bcc763f',
                amarillo: '#FFA823',
                rojo: '#FF3131',
                rojo_opacity : '#ff31312d'
              },
              secundary: {
                default: '#1A2130',
                light: '#A5B8D4',
                opacity: 'rgba(26, 33, 48, 0.479)'
              },
              machine: {
                primary: '#57CC99',
                secundary: '#C7F9CC',
                complement: '#80ED99'
              },
              guru: {
                primary: '#BB9457',
                secundary: '#FFE6A7',
                complement: '#99582A'
              },
              shopper: {
                primary: '#3D4AEE',
                secundary: '#87A2FF',
                complement: '#8E9AAF'
              },
              essentials: {
                primary: '#FF4D6D',
                secundary: '#FFB3C1',
                complement: '#FF758F'
              },
              smart: {
                primary: '#DEE2FF',
                secundary: '#FEEAFA',
                complement: '#EFD3D7'
              },
          },
      },
  },
    plugins: [],
  };
  