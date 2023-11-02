export default {
  routes: [
    {
      method: 'GET',
      path: '/custom',
      handler: 'todo.customAction',
      config: {
        auth: false,
      },
    },
  ],
};
