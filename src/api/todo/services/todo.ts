/**
 * todo service
 */

import { factories } from '@strapi/strapi';

export default factories.createCoreService('api::todo.todo', ({strapi}) => ({
    async customService(...args) {
        const response = { okay: true };

        if (response.okay === false) {
          return { response, error: true };
        }
    
        return response;
    },
    async find(...args) {
        const { results, pagination } = await super.find(...args);
        results.forEach(result => {
            result.counter = 1;
        });
        return {results, pagination};
    },
    async findOne(entityId, params = {}) {
        return strapi.entityService.findOne('api::todo.todo', entityId, super.getFetchParams(params));
    }
}));
