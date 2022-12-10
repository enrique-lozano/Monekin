export const defaultCategories: {
  names: { en: string; es: string };
  icon: string;
  color: string;
  type: 'E' | 'I' | 'B';
  subcategories?: { names: { en: string; es: string }; icon: string }[];
}[] = [
  {
    names: {
      en: 'Aesthetics & Health',
      es: 'Salud & belleza',
    },
    icon: 'pulse',
    color: 'CC0605',
    type: 'E',
    subcategories: [
      {
        icon: 'body',
        names: {
          es: 'Cuidado personal',
          en: 'Personal care',
        },
      },
      {
        icon: 'medkit',
        names: {
          es: 'Médico',
          en: 'Medical',
        },
      },
      {
        icon: 'barbell',
        names: {
          es: 'Fitness',
          en: 'Fitness',
        },
      },
    ],
  },
  {
    names: {
      en: 'Food & Dining',
      es: 'Alimentación',
    },
    icon: 'cart',
    color: 'F4A900',
    type: 'E',
    subcategories: [
      {
        icon: 'restaurant',
        names: {
          es: 'Comer fuera',
          en: 'Eating out',
        },
      },
      {
        icon: 'nutrition',
        names: {
          es: 'Comestibles',
          en: 'Groceries',
        },
      },
    ],
  },
  {
    names: {
      en: 'Purchases',
      es: 'Compras',
    },
    icon: 'bag-handle',
    color: '3D642D',
    type: 'E',
    subcategories: [
      {
        icon: 'library',
        names: {
          es: 'Papelería',
          en: 'Stationery',
        },
      },
      {
        icon: 'desktop',
        names: {
          es: 'Electrónica',
          en: 'Electronics',
        },
      },
      {
        icon: 'shirt',
        names: {
          es: 'Ropa',
          en: 'Clothes',
        },
      },
    ],
  },
  {
    names: {
      en: 'Leisure',
      es: 'Entretenimiento',
    },
    icon: 'golf',
    color: '2A6478',
    type: 'E',
    subcategories: [
      {
        icon: 'beer',
        names: {
          es: 'Fiesta',
          en: 'Party',
        },
      },
      {
        icon: 'ticket',
        names: {
          es: 'Eventos y sitios de interes',
          en: 'Sites of interest and events',
        },
      },
      {
        icon: 'musical-notes',
        names: {
          es: 'Música y conciertos',
          en: 'Music',
        },
      },
      {
        icon: 'film',
        names: {
          es: 'Cine y TV',
          en: 'TV-shows and movies',
        },
      },
    ],
  },
  {
    names: {
      en: 'Transportation',
      es: 'Transporte',
    },
    icon: 'bus',
    color: '84C3BE',
    type: 'E',
    subcategories: [
      {
        icon: 'train',
        names: {
          es: 'Transporte público',
          en: 'Public Transport',
        },
      },
      {
        icon: 'speedometer',
        names: {
          es: 'Gasolina',
          en: 'Fuel',
        },
      },
      {
        icon: 'trail-sign',
        names: {
          es: 'Multas y parkimétros',
          en: 'Tolls and parking',
        },
      },
      {
        icon: 'receipt',
        names: {
          es: 'Seguro e impuestos',
          en: 'Taxes and car insurance',
        },
      },
      {
        icon: 'hammer',
        names: {
          es: 'Mantenimiento',
          en: 'Maintenance',
        },
      },
    ],
  },
  {
    names: {
      en: 'Housing',
      es: 'Hogar',
    },
    icon: 'home',
    color: '4E5452',
    type: 'E',
    subcategories: [
      {
        icon: 'key',
        names: {
          es: 'Alquiler',
          en: 'Rental',
        },
      },
      {
        icon: 'water',
        names: {
          es: 'Agua',
          en: 'Water',
        },
      },
      {
        icon: 'flash',
        names: {
          es: 'Luz',
          en: 'Electricity',
        },
      },
      {
        icon: 'globe',
        names: {
          es: 'Internet',
          en: 'Internet',
        },
      },
      {
        icon: 'call',
        names: {
          es: 'Teléfono',
          en: 'Phone',
        },
      },
      {
        icon: 'sparkles',
        names: {
          es: 'Productos para el hogar',
          en: 'Home supplies',
        },
      },
      {
        icon: 'bed',
        names: {
          es: 'Muebles y accesorios',
          en: 'Furniture and appliances',
        },
      },
    ],
  },
  {
    names: {
      en: 'Taxes',
      es: 'Impuestos',
    },
    icon: 'receipt',
    color: 'B32821',
    type: 'E',
  },
  {
    names: {
      en: 'Plants & Pets',
      es: 'Plantas & mascotas',
    },
    icon: 'paw',
    color: '587246',
    type: 'E',
    subcategories: [],
  },
  {
    names: {
      en: 'Holidays',
      es: 'Vacaciones',
    },
    icon: 'image',
    color: 'FF7514',
    type: 'E',
    subcategories: [
      {
        icon: 'airplane',
        names: {
          es: 'Viaje',
          en: 'Travel',
        },
      },
      {
        icon: 'bed',
        names: {
          es: 'Alojamiento',
          en: 'Accommodation',
        },
      },
    ],
  },
  {
    names: {
      en: 'Salary',
      es: 'Salario',
    },
    icon: 'briefcase',
    color: '4C9141',
    type: 'I',
  },
  {
    names: {
      en: 'Gifts & Donations',
      es: 'Regalos & Donaciones',
    },
    icon: 'gift',
    color: 'BB4B4B',
    type: 'B',
  },
  {
    names: {
      en: 'Sale',
      es: 'Venta',
    },
    icon: 'exit',
    color: 'CDA434',
    type: 'I',
  },
  {
    names: {
      en: 'Investments',
      es: 'Inversión',
    },
    icon: 'analytics',
    color: '1E2460',
    type: 'B',
  },
  {
    names: {
      en: 'Gambling',
      es: 'Juegos & apuestas',
    },
    icon: 'dice',
    color: '2A6478',
    type: 'B',
  },
  {
    names: {
      en: 'Awards & Honours',
      es: 'Premios & reconocimientos',
    },
    icon: 'trophy',
    color: 'F39F18',
    type: 'I',
  },
  {
    names: {
      en: 'Debts',
      es: 'Deudas & devoluciones',
    },
    icon: 'arrow-redo',
    color: '781F19',
    type: 'E',
  },
  {
    names: {
      en: 'Loans',
      es: 'Préstamos',
    },
    icon: 'arrow-undo',
    color: '781F19',
    type: 'I',
  },
  {
    names: {
      en: 'Others',
      es: 'Otros',
    },
    icon: 'cube',
    color: '403A3A',
    type: 'B',
  },
];
