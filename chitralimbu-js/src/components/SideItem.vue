<template>
  <div class="accordion-item">
    <h2 class="accordion-header" :id="item.title">
      <button
        class="accordion-button collapsed"
        type="button"
        data-bs-toggle="collapse"
        :data-bs-target="`#${this.title}-panel`"
        aria-expanded="false"
        :aria-controls="`${this.title}-panel`"
      >
        Accordion Item #2
      </button>
    </h2>
    <div
      :id="`${this.title}-panel`"
      class="accordion-collapse collapse"
      :aria-labelledby="item.title"
    >
      <div class="accordion-body">
        <ul v-if="item.isList === true" class="list-group list-group-flush">
          <li
            :key="index"
            v-for="(listItem, index) in item.subList"
            class="list-group-item"
          >
            {{ listItem.subTitle }}
          </li>
          <!--          <li class="list-group-item">An item</li>
          <li class="list-group-item">A second item</li>
          <li class="list-group-item">A third item</li>
          <li class="list-group-item">A fourth item</li>
          <li class="list-group-item">And a fifth one</li>-->
        </ul>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "SideItem",
  props: {
    item: Object,
  },
};
</script>
<style scoped></style>
