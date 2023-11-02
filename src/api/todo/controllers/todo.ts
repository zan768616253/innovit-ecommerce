/**
 * todo controller
 */

import { factories } from '@strapi/strapi';

export default factories.createCoreController('api::todo.todo', ({ strapi }) => ({
  async customAction(ctx) {
    try {
      await strapi.service('api::todo.todo').customService();
      ctx.body = 'ok, hello world';
    } catch (err) {
      ctx.body = err;
    }
  },
  async find(ctx) {
    ctx.query = { ...ctx.query, local: 'en' };

    const { data, meta } = await super.find(ctx);

    meta.date = Date.now();

    return { data, meta };
  },
  async findOne(ctx) {
    const { id } = ctx.params;
    const { query } = ctx;

    const entity = await strapi.service('api::todo.todo').findOne(id, query);
    const sanitizedEntity = await this.sanitizeOutput(entity, ctx);

    return this.transformResponse(sanitizedEntity);
  },
}));
